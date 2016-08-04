//
//  Tealium+Lifecycle.h
//  UIKitCatalog
//
//  Created by Jason Koo on 3/1/16.
//  Copyright © 2016 f. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef TEAL_SOURCE

#import "Tealium.h"

#elif defined(TEAL_TARGET_IOS)

#import <TealiumIOS/TealiumIOS.h>

#elif defined(TEAL_TARGET_TVOS)

#import <TealiumTVOS/TealiumTVOS.h>

#endif


/**
 *  Category on the Tealium object that adds lifecycle tracking features.
 */
@interface Tealium (Lifecycle)

/**
 *  Enables automatic lifecycle tracking. If enabling, should be done just after Tealium
 *      library instance is called so the first launch event is also autmoatically tracked.
 *      If the initial launch event is not being captured, then the UIApplicationDidFinishLaunching
 *      notification has already occurred prior to this toggle.
 *
 *  @param autotracking Boolean indicating whether to use autotracking or not. Default is NO.
 */
- (void) setLifecycleAutotrackingIsEnabled:(BOOL)autotracking __attribute__((deprecated("Use the TEALConfiguration setLifecycleAutotrackingEnabled option instead")));
    
/**
 *  Use to manually record an app launch event.
 */
- (void) launch;

/**
 *  Use to record an app wake event.
 */
- (void) wake;

/**
 *  Use to record an app sleep event.
 */
- (void) sleep;

/**
 *  Use to manually record an app launch event.
 *
 *  @param dataSources NSDictionary of optional, additional data source key and values.
 */
- (void) launchWithDataSources:(NSDictionary * _Nullable)dataSources;

/**
 *  Use to manually record an app wake event.
 *
 *  @param dataSources NSDictionary of optional, additional data source key and values.
 */
- (void) wakeWithDataSources:(NSDictionary * _Nullable)dataSources;

/**
 *  Use to manually record an app sleep event.
 *
 *  @param dataSources NSDictionary of optional, additional data source key and values.
 */
- (void) sleepWithDataSources:(NSDictionary * _Nullable)dataSources;

/**
 *  Convenience method for updating a numeric persistent value using Tealium's
 *  persistent Data Sources.
 *
 *  @param keys NSArray of NSString key identifiers to increment
 *  @param number Integer number to increment value for
 */
- (void) incrementLifetimeValuesForKeys:(NSArray * _Nonnull)keys
                                 amount:(int)number;


/**
 * Current lifecycle data at time of call.  This dictionary can be added into
 * a Tealium track call's dataSources: argument or to a TEALDispatch's payload
 * property to be sent with a given event dispatch.
 *
 *  @param overrideDate Optional date to calculate lifecycle data from. Nil recommended
 *      for most use cases.
 *
 *  @return NSDictionary with all Lifecycle data source keys and values.
 */
- (NSDictionary * _Nonnull) currentLifecycleDataSources:(NSDate * _Nullable)overrideDate;

@end
