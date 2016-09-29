//  Created by Jay Marcyes on 9/12/15.

#import "CocoaLumberJill.h"
#import "CLJLogFormatter.h"


/**
 *  this is just a placeholder, you should actually manipulate the log level
 *  using the setLogLevelFromString: method
 *
 *  @link http://www.egeek.me/2013/06/09/global-dynamic-log-level-in-cocoalumberjack/
 */
DDLogLevel ddLogLevel = DDLogLevelInfo;


@implementation CocoaLumberjill

+ (CLJLogEmail *)emailInstance
{
    return [CLJLogEmail sharedInstance];
}

+ (void)configureWithLogLevel:(NSString *)logLevel
{
    [self configure];
    [self setLogLevelFromString:logLevel];
}

+ (void)configure
{
    CLJLogFormatter *formatter = [CLJLogFormatter new];
    
    // adds logging to Apple System Log - can be set to a restrictive logging level now that we are logging to a file
    [[DDASLLogger sharedInstance] setLogFormatter:formatter];
    [DDLog addLogger:[DDASLLogger sharedInstance] withLevel:DDLogLevelError];
    
    // adds logging to XCode console
    [[DDTTYLogger sharedInstance] setLogFormatter:formatter];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    // This only works with XcodeColors plugin that doesn't work with Xcode 8+
    // https://github.com/CocoaLumberjack/CocoaLumberjack/blob/master/Documentation/XcodeColors.md
    // #21621A
    ///UIColor *color = [UIColor colorWithRed:33/255 green:98/255 blue:26/255 alpha:1.0];
    ///UIColor *color = [UIColor greenColor];
    ///[[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    ///[[DDTTYLogger sharedInstance] setForegroundColor:color backgroundColor:nil forFlag:DDLogFlagInfo];
    
    // adds logging to file
    DDFileLogger *fileLogger = [DDFileLogger new];
    fileLogger.rollingFrequency = 86400; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [fileLogger setLogFormatter:formatter];
    [DDLog addLogger:fileLogger];
}

+ (void)setLogLevelFromString:(NSString *)logLevel
{
    logLevel = logLevel.lowercaseString;
    
    if ([logLevel isEqualToString:@"verbose"]) {
        ddLogLevel = DDLogLevelVerbose;
        
    } else if ([logLevel isEqualToString:@"all"]) {
        ddLogLevel = DDLogLevelAll;
        
    } else if ([logLevel isEqualToString:@"debug"]) {
        ddLogLevel = DDLogLevelDebug;
        
    } else if ([logLevel isEqualToString:@"info"]) {
        ddLogLevel = DDLogLevelInfo;
    
    } else if ([logLevel isEqualToString:@"warn"]) {
        ddLogLevel = DDLogLevelWarning;
        
    } else if ([logLevel isEqualToString:@"error"]) {
        ddLogLevel = DDLogLevelError;
        
    } else if ([logLevel isEqualToString:@"off"]) {
        ddLogLevel = DDLogLevelOff;
        
    }

}

@end
