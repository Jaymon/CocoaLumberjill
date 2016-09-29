//  Created by Jay Marcyes on 9/12/15.

@import Foundation;
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "CLJLogMacros.h"
#import "CLJLogEmail.h"


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
 The public interface to sending the logs via email
 */
@property (nonatomic, readonly, nonnull) CLJLogEmail *emailInstance;

/**
 configure the logger with the given loglevel
 
 basically this just calls configure and setLogLevelFromString: in one call

 @param logLevel see setLogLevelFromString: for the value (eg, all, debug, warn)
 */
+ (void)configureWithLogLevel:(nonnull NSString *)logLevel;

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
+ (void)setLogLevelFromString:(nonnull NSString *)logLevel;

@end
