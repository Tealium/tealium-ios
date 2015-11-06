//
//  TealiumDelegate.h
//  Tealium
//
//  Created by Jason Koo on 7/22/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Tealium;
@class TEALDispatch;

/**
 *  Optional Tealium Delegate for monitoring or overriding outbound dispatches.
 */
@protocol TealiumDelegate <NSObject>

@optional

/**
 *  Delegate method that permits last minute manipulation or suppression (destruction)
 *      of a track call dispatch.
 *
 *  @param tealium The Tealium instance to process this dispatch
 *  @param dispatch The dispatch in question. Property and payload data manipulated
 *          here will overwrite this dispatch's outbound data - effects not
 *          persistent
 *
 *  @return Boolean indicating whether dispatch should be sent or destroyed
 */
- (BOOL) tealium:(Tealium *)tealium shouldDropDispatch:(TEALDispatch *)dispatch;

/**
 *  Dispatches passing the tealium:shouldDropDispatch: delegate method can be
 *      queued / saved by this method.  Also supercedes any remote publish setting
 *      batching and offline options. Must include logic to return NO or dispatches
 *      will never be sent.
 *
 *  @param tealium The Tealium instance requesting confirmation
 *  @param dispatch The dispatch in question. Property and payload data manipulated
 *          here will overwrite this dispatch's outbound data - effects not
 *          persistent
 *
 *  @bool Boolean indicating whether dispatch should be queued at this time.
 */
- (BOOL) tealium:(Tealium *)tealium shouldQueueDispatch:(TEALDispatch *)dispatch;

/**
 *  Provides pointer to TEALDispatch that was just sent by a dispatch service.
 *
 *  @param tealium The Tealium instance confirming
 *  @param dispatch The dispatch in question. Do not manipulate any of its
 *          properties or payload data here as they will not take effect or
 *          persist.
 *
 */
- (void) tealium:(Tealium *)tealium didSendDispatch:(TEALDispatch *)dispatch;

/**
 *  Provides pointer to TEALDispatch that was just saved for later delivery.
 *
 *  @param tealium The Tealium instance confirming
 *  @param dispatch The dispatch in question. Do not manipulate any of its 
 *          properties or payload data here as they will not take effect or
 *          persist.
 *
 */
- (void) tealium:(Tealium *)tealium didQueueDispatch:(TEALDispatch *)dispatch;

/**
 *  Notification that new remote publish settings have been received and processed.
 *
 *  @param tealium The Tealium instance with new publish settings.
 */
- (void) tealiumInstanceDidUpdatePublishSettings:(Tealium *)tealium;

/*
 *  If Tag Management dispatch service is enabled, passes pointer to it's UIWebView
 *  that hosts UTAG.js
 *
 *  @param tealium The Tealium instance ready
 *  @param webView The WebView instance used by any Tag Management service - nil 
 *          if none initialized.
 */
- (void) tealium:(Tealium *)tealium webViewIsReady:(id)webView;

@end
