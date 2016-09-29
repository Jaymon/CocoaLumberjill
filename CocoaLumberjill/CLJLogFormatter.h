//  Created by Jay Marcyes on 9/28/16.

@import Foundation;
#import <CocoaLumberjack/CocoaLumberjack.h>

/**
 *  Internal logging formatter class, I found the default system logging really verbose
 *  in a bad way, full of useless information and yet taking up half of the console,
 *  this formatter will hopefully fix that and show us information we actually want
 */
@interface CLJLogFormatter : NSObject <DDLogFormatter>

@end
