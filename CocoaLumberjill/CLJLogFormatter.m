//  Created by Jay Marcyes on 9/28/16.


#import "CLJLogFormatter.h"

@implementation CLJLogFormatter {
    
    NSDateFormatter *_dateFormatter;
}

- (instancetype)init {
    if((self = [super init])) {
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setDateFormat:@"MM-dd-yy HH:mm:ss:SSS"];
    }
    return self;
}

/**
 *  Currently sets up a log message in the form of
 *
 *  [E|11-23-15 15:19:31:065] ... [Filename:LINE]
 */
- (NSString*)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *logLevel = nil;
    switch (logMessage->_flag) {
        case DDLogFlagError    : logLevel = @"E"; break;
        case DDLogFlagWarning  : logLevel = @"W"; break;
        case DDLogFlagInfo     : logLevel = @"I"; break;
        case DDLogFlagDebug    : logLevel = @"D"; break;
        default                : logLevel = @"V"; break;
    }
    
    NSString *datestamp = [_dateFormatter stringFromDate:(logMessage->_timestamp)];
    
    return [NSString stringWithFormat:@"[%@|%@] %@ [%@:%ld]",
            logLevel,
            datestamp,
            logMessage->_message,
            // we move these to after the message since they are variable length
            logMessage->_fileName,
            (unsigned long)logMessage->_line
            ];
    
}
@end

