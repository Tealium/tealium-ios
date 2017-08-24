//
//  Tealium.h
//  test_tealium_objc
//
//  Created by Jason Koo on 7/21/17.
//  Copyright © 2017 tealium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface Tealium : NSObject

extern NSString * _Nonnull const TealiumCollectBaseURL;
extern NSString * _Nonnull const TealiumFeatureIQ;
extern NSString * _Nonnull const TealiumFeatureUDH;


@property (nonatomic) NSDictionary * _Nonnull basePayload;
@property (nonatomic) NSURLSession * _Nullable defaultSession;
@property(strong,nonatomic) WKWebView * _Nullable tealWebView;
@property (nonatomic, strong) NSMutableArray * _Nullable dispatchQueue;
@property (nonatomic) BOOL webViewInitialLoadFinished;
@property (nonatomic) BOOL networkIsReachable;
@property (nonatomic) NSString * _Nullable account;
@property (nonatomic) NSString * _Nullable profile;
@property (nonatomic) NSString * _Nullable environment;
@property (nonatomic) NSString * _Nullable domainOverride;
@property (nonatomic) BOOL featureIQ;
@property (nonatomic) BOOL featureUDH;

/**
 Constructor for a tealium object.
 
 @param account Tealium account name.
 @param profile Tealium profile name.
 @param data Optional additional data to set with base payload. Data that will be sent with each dispatch call.
 @return Instance of a tealium object.
 */
+ (instancetype _Nonnull ) instanceWithAccount: (NSString * __nonnull) account
                                       profile: (NSString * __nonnull) profile
                                   environment: (NSString * __nonnull) env
                                domainOverride: (NSString * __nullable) domainOverride
                                enableFeatures: (NSArray * __nullable) features
                                additionalData: (NSDictionary * __nullable) data;

/**
 Method to invoke a track event call.
 
 @param title Title to use - becomes value for tealium_event key.
 @param data Optional additional data for call.
 */
-  (void) trackView: (NSString* __nonnull) title
        payload: (NSDictionary* __nullable) data
     completion: (void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)) completion;

-  (void) trackEvent: (NSString* __nonnull) title
            payload: (NSDictionary* __nullable) data
         completion: (void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)) completion;


@end

@interface NSMutableArray (Queue)

- (void) enqueue: (id _Nullable )item;
- (id _Nullable) dequeue;
- (id _Nullable) peek;

@end
