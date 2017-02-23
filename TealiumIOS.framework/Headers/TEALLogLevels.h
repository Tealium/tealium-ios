//
//  TEALLogLevels.h
//  FrameworkBuilder
//
//  Created by Jason Koo on 2/18/17.
//  Copyright © 2017 Tealium. All rights reserved.
//

#ifndef TEALLogLevels_h
#define TEALLogLevels_h

/**
 *  Unsigned integer value that controls the verbosity level of any log output.
 */
typedef NS_ENUM(NSUInteger, TEALLogLevel){
    /**
     *  Nothing is logged to the console, this is the default.
     */
    TEALLogLevelNone = 0,
    /**
     *  Only errors reported.
     */
    TEALLogLevelProd,
    /**
     *  Provides warnings and errors only.
     */
    TEALLogLevelQA,
    /**
     *  Most verbose - Useful for debugging and verification during development.
     */
    TEALLogLevelDev
    
    
};


#endif /* TEALLogLevels_h */
