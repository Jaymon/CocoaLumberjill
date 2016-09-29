//  Created by Jay Marcyes on 9/12/15.

@import Foundation;
///#import "DDLog.h"
#import <CocoaLumberjack/CocoaLumberjack.h>


/**
 *  CocoaLumberjack needs this to function, it's set through setLogLevelFromString:
 *
 *  @see setLogLevelFromString:
 */
extern DDLogLevel ddLogLevel;


/**
 *  Handles setup and configuration of our Cocoalumberjack logging
 */
@interface CocoaLumberjill : NSObject


/**
 configure the logger with the given loglevel
 
 basically this just calls configure and setLogLevelFromString: in one call

 @param logLevel see setLogLevelFromString: for the value (eg, all, debug, warn)
 */
+ (void)configureWithLogLevel:(NSString *)logLevel;

/**
 *  configures the loggers we use, this is meant to be called from wherever you
 *  configure things
 */
+ (void)configure;

/**
 *  given a string like @"info" set the global ddLogLevel the CocoaLumberjack uses
 *
 *  @param  logLevel    value of verbos, debug, info, warn, error, or off
 */
+ (void)setLogLevelFromString:(NSString *)logLevel;

@end


/**
 *  Internal logging formatter class, I found the default system logging really verbose
 *  in a bad way, full of useless information and yet taking up half of the console,
 *  this formatter will hopefully fix that and give us information we can actually
 *  use.
 */
@interface CLJLogFormatter : NSObject <DDLogFormatter>

@end