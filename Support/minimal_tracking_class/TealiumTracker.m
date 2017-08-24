//
//  Tealium.m
//  test_tealium_objc
//
//  Created by Jason Koo on 7/21/17.
//  Updated by Craig Rouse on 8/22/17 - Tag Management Added
//  Copyright © 2017 tealium. All rights reserved.
//

#import "TealiumTracker.h"

@import Security;

@interface Tealium() <WKNavigationDelegate>

@end

@implementation Tealium

NSString * const TealiumCollectBaseURL = @"https://collect.tealiumiq.com/vdata/i.gif?";
NSString * const TealiumKeyAccount = @"tealium_account";
NSString * const TealiumKeyEvent = @"tealium_event";
NSString * const TealiumKeyProfile = @"tealium_profile";
NSString * const TealiumKeyVisitorId = @"tealium_visitor_id";
NSString * const TealiumKeyPrefix = @"com.tealium.";
NSString * const TealiumEventTypeView = @"view";
NSString * const TealiumEventTypeLink = @"link";
NSString * const TealiumKeyEventType = @"tealium_event_type";
NSString * const TealiumFeatureUDH = @"udh";
NSString * const TealiumFeatureIQ = @"iq";
NSString * const TealiumClassVersion = @"0.1";
NSString * const TealiumKeyClassVersion = @"tealium_tracking_class_version";


+ (instancetype _Nonnull ) instanceWithAccount: (NSString * __nonnull) account
                                       profile: (NSString * __nonnull) profile
                                   environment: (NSString * __nonnull) env
                                domainOverride: (NSString * __nullable) domainOverride
                                enableFeatures: (NSArray * __nullable) features
                                additionalData: (NSDictionary * __nullable) data{
    
    Tealium * tealium = [Tealium new];
    NSString * vid = [tealium visitorIdFor:account
                                   profile:profile];
    tealium.featureIQ = NO;
    tealium.featureUDH = NO;
    tealium.account = account;
    tealium.profile = profile;
    tealium.environment = env;
    tealium.domainOverride = domainOverride;
    
    if (features != nil) {
        for (NSString* item in features) {
            if ([item isEqualToString:TealiumFeatureIQ]) {
                tealium.featureIQ = YES;
            } else if ([item isEqualToString:TealiumFeatureUDH]) {
                tealium.featureUDH = YES;
            }
        }
    }
    
    [tealium setBasePayloadWithAccount:account
                               profile:profile
                             visitorId:vid
                        additionalData:data];
    
    if (tealium.featureUDH == YES) {
        [tealium setupSession];
    }
    if (tealium.featureIQ == YES) {
        [tealium initTagManagementWithAccount:account profile:profile environment:env domainOverride:domainOverride];
    }
    
    return tealium;
}

- (void)setupSession {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.URLCache = nil;
    config.timeoutIntervalForRequest = 20.0;
    config.URLCredentialStorage = nil;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    self.defaultSession = [NSURLSession sessionWithConfiguration:config];
    config = nil;
}

// MARK: All -> Base Payload
/**
 Set the required data for valid Collect calls.
 
 @param account Tealium account name.
 @param profile Tealium profile name.
 @param vid Tealium visitor id to use. Should be unique per app/device instance and be persistent.
 @param data Any optional data to add to each call.
 */
- (void) setBasePayloadWithAccount:(NSString * __nonnull) account
                           profile:(NSString * __nonnull) profile
                         visitorId:(NSString * __nonnull) vid
                    additionalData:(NSDictionary * _Nullable)data {
    
    
    NSMutableDictionary * baseData = [NSMutableDictionary dictionary];
    baseData[TealiumKeyAccount] = account;
    baseData[TealiumKeyProfile] = profile;
    baseData[TealiumKeyVisitorId] = vid;
    baseData[TealiumKeyClassVersion] = TealiumClassVersion;
    [baseData addEntriesFromDictionary:data];
    
    self.basePayload = baseData;
}

// MARK: All -> Master Track method
- (void) track:(NSString *) title
       payload:(NSDictionary *) data
    completion:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)) completion {
    
    NSMutableDictionary * dataStream = [NSMutableDictionary dictionary];
    dataStream[TealiumKeyEvent] = title;
    [dataStream addEntriesFromDictionary:_basePayload];
    [dataStream addEntriesFromDictionary:data];
    
    NSString * baseUrl = TealiumCollectBaseURL;
    if (self.featureUDH == YES) {
        [self sendToCollect:dataStream
                   endpoint:baseUrl
                 completion:completion];
        
    }
    if (self.featureIQ == YES) {
        [self queueDispatchForTagManagement:dataStream];
    }
    
}
// MARK: All -> View Tracking
- (void) trackView:(NSString *) title
           payload:(NSDictionary *) data
        completion:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)) completion {
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:data];
    temp[TealiumKeyEventType] = TealiumEventTypeView;
    [self track:title payload:temp completion:nil];
}

// MARK: All -> Event Tracking
- (void) trackEvent:(NSString *) title
            payload:(NSDictionary *) data
         completion:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)) completion {
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:data];
    temp[TealiumKeyEventType] = TealiumEventTypeView;
    [self track:title payload:temp completion:nil];
}

// MARK: All -> New Visitor ID
- (NSString * __nonnull) visitorIdFor:(NSString * __nonnull) account
                              profile:(NSString * __nonnull) profile {
    
    NSString * initialKey = [TealiumKeyPrefix stringByAppendingString:account];
    NSString * midKey = [initialKey stringByAppendingString:@"."];
    NSString * key = [midKey stringByAppendingString:profile];
    NSString * vid = [NSUserDefaults.standardUserDefaults objectForKey:key];
    
    if (vid == nil) {
        vid = [Tealium newVisitorId];
        [NSUserDefaults.standardUserDefaults setObject:vid
                                                forKey:key];
        [NSUserDefaults.standardUserDefaults synchronize];
    }
    
    return vid;
    
}

// MARK: All -> New UUID
/**
 Convenience for converting a standard UUID alphanumeric string to a valid Tealium Collect visitor id.
 
 @param uuid Universally Unique IDentifier
 @return A uuid string stripped of dashes (-)
 */
+ (NSString * __nonnull) visitorIdFrom:(NSString * __nonnull) uuid {
    return [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

// MARK: All -> New VID
/**
 Convenience for creating a new visitor id for use in the basePayload property. Note this id should be reused for each app launch/wake. This class does NOT persist this data automatically.
 
 @return A UUID string stripped of dashes (-)
 */
+ (NSString* __nonnull) newVisitorId{
    
    NSString * uuid = [[NSUUID UUID] UUIDString];
    NSString * visitorID = [Tealium visitorIdFrom:uuid];
    return visitorID;
    
}

// MARK: Collect -> Send Data
- (void) sendToCollect:(NSDictionary * __nonnull) payload
              endpoint:(NSString * __nonnull) baseUrl
            completion:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)) completion{
    NSString *urlEncodedParams = [Tealium urlParamStringFromDictionary:payload];
    NSString *urlString = [baseUrl stringByAppendingString:urlEncodedParams];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionTask *task = [self.defaultSession dataTaskWithRequest:request
                                        completionHandler:completion];
    [task resume];
    
}

// Convenience for converting an NSDictionary of data to an NSString of URL params
+ (NSString *) urlParamStringFromDictionary:(NSDictionary *)data {
    
    if (!data){ return @""; }
    NSMutableArray *paramArray = [NSMutableArray array];
    [data enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *stringValue = [NSString stringWithFormat:@"%@", obj];
        NSString *escapedValue = [stringValue stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLHostAllowedCharacterSet];;
        NSString *paramStr = [NSString stringWithFormat:@"%@=%@", key, escapedValue];
        [paramArray addObject:paramStr];
    }];
    return [paramArray componentsJoinedByString:@"&"];
    
}


// MARK: TiQ Tag Management (TM)

// MARK: TM -> Init
// loads the tag management webview
- (void) initTagManagementWithAccount: (NSString *) account
                              profile: (NSString *) profile
                          environment: (NSString *) env
                       domainOverride: (NSString *) domain

{
    if (domain == nil) {
        domain = @"https://tags.tiqcdn.com";
    }
    NSString *tmFullURL = [NSString stringWithFormat:@"%@/utag/%@/%@/%@/mobile.html", domain, account, profile, env];
    NSURL *wvURL = [NSURL URLWithString:tmFullURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:wvURL];
    WKWebViewConfiguration *wvConfig = [[WKWebViewConfiguration alloc] init];
    
    _tealWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wvConfig];
    [_tealWebView setNavigationDelegate: self];
    [_tealWebView loadRequest:request];
}

// MARK: TM -> Queue
// stores a dispatch in the queue for later sending
- (void) queueDispatchForTagManagement: (NSDictionary *) dispatch {
    NSError *error = nil;
    @autoreleasepool {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dispatch options:0 error:&error];
        if (jsonData != nil) {
            if (_dispatchQueue == nil) {
                _dispatchQueue = [NSMutableArray array];
            }
            [_dispatchQueue enqueue:jsonData];
        }
    }
    [self flushDispatchQueue];
}

// MARK: TM -> Flush Queue
// flush any queued dispatches
- (void) flushDispatchQueue {
    if (_dispatchQueue == nil || [_dispatchQueue count] == 0) {
        return;
    }
    
    if (self.webViewInitialLoadFinished == YES) {
        NSData * dispatch;
        while ((dispatch = [_dispatchQueue dequeue]) != nil) {
            [self sendDispatchToTagManagement:dispatch];
        }
    } else {
        // attempt to reload webview and flush queue
        [self initTagManagementWithAccount:self.account profile:self.profile environment:self.environment domainOverride:self.domainOverride];
    }
}

// MARK: TM -> Send To Webview
// sends dequeued dispatches to webview
- (void) sendDispatchToTagManagement: (NSData *) data {

    if (data != nil) {
        NSObject * jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSString *jsonDataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString * trackType = [jsonObject valueForKey:TealiumKeyEventType];
        NSString *command = [NSString stringWithFormat:@"utag.track('%@', %@)", trackType, jsonDataString];
        [_tealWebView evaluateJavaScript:command completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"Tag management command returned an error %@", error);
            }
        }];
    }
}

// MARK: WKWebview Delegate
// webview finished loading
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.webViewInitialLoadFinished = YES;
    [self flushDispatchQueue];
}

// MARK: WKWebview Delegate
// webview failed to load (e.g. no connection)
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error
{
    self.webViewInitialLoadFinished = NO;
    NSLog(@"Tag management webview failed to load with error %@", error);
}

@end

// MARK: Util -> Array Extensions
@implementation NSMutableArray (Queue)

- (void) enqueue: (id)item {
    [self addObject:item];
}

- (id) dequeue {
    id item = nil;
    if ([self count] != 0) {
        item = [self objectAtIndex:0];
        [self removeObjectAtIndex:0];
    }
    return item;
}

- (id) peek {
    id item = nil;
    if ([self count] != 0) {
        item = [self objectAtIndex:0];
    }
    return item;
}

@end
