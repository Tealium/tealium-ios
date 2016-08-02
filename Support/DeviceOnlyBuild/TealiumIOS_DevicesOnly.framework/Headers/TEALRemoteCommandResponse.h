//
//  TEALRemoteCommandResponse.h
//  Tealium
//
//  Created by Jason Koo on 8/25/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TEALRemoteCommandResponseDelegate ;

/**
 *  A response object for triggered Remote Commands.
 */
@interface TEALRemoteCommandResponse : NSObject

@property (nonatomic, weak)     id <TEALRemoteCommandResponseDelegate> delegate;
@property (nonatomic, strong)   NSString        *body;
@property (nonatomic, strong)   NSString        *commandId;
@property (nonatomic, strong)   NSError         *error;
@property (nonatomic, strong)   NSString        *responseId;
@property (nonatomic, strong)   NSDictionary    *requestPayload;
@property (nonatomic)           NSInteger       status;

typedef void (^ TEALRemoteCommandResponseBlock)(TEALRemoteCommandResponse *response);

@end

