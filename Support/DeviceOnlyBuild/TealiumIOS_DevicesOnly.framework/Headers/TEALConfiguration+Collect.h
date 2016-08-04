//
//  TEALConfiguration+Collect.h
//  UIKitCatalog
//
//  Created by Jason Koo on 1/9/16.
//
//

#import "TEALConfiguration.h"

/**
 *  Unsigned integer value that controls the frequency at which the user's visitor profile is requested
 */
typedef NS_ENUM(NSUInteger, TEALVisitorProfilePollingFrequency){
    /**
     *  On request only, will only poll with the fetchVisitorProfileWithCompletion: method
     */
    TEALVisitorProfilePollingFrequencyOnRequest = 0,
    /**
     *  After each track event (trackEventWithTitle:dataSources: or trackViewWithTitle:dataSources:) an updated visitor profile will be requested.
     */
    TEALVisitorProfilePollingFrequencyAfterEveryEvent
};


@interface TEALConfiguration (Collect)

/**
 *  If assigned, will replace the destination endpoint for Collect dispatch calls.
 */
- (NSString * _Nullable) overrideCollectDispatchURL;

/**
 *  If assigned, will replace the destination endpoint for S2S Legacy dispatch calls.
 */
- (NSString * _Nullable) overrideS2SLegacyDispatchURL;

/**
 *  Frequency at which visitor profile should be polled.
 */
- (TEALVisitorProfilePollingFrequency) collectPollingFrequency;

/**
 *  Set the destination endpoint for Collect dispatch calls.
 *
 *  @param overrideURL The NSString representation of the target URL address to use.
 */
- (void) setOverrideCollectDispatchURL:(NSString * _Nonnull) overrideURL;

/**
 *  Set the destination endpoint for Legacy S2S dispatch calls.
 *
 *  @param overrideURL The NSString representation of the target URL address to use.
 */
- (void) setOverrideS2SLegacyDispatchURL:(NSString * _Nonnull)overrideURL;

/**
 *  Set the visitor profile polling frequency mode.
 *
 *  By default after each sendEventWithData: and sendViewWithData: call an updated visitor profile will be requested.
 *  If set to on request, the library will only requery the profile when asked for using fetchVisitorProfileWithCompletion:
 *
 *  @default TEALVisitorProfilePollingFrequencyAfterEveryEvent
 *  @see TEALVisitorProfilePollingFrequency
 */
- (void) setCollectPollingFrequency:(TEALVisitorProfilePollingFrequency)frequency;

@end
