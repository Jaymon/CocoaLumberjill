//  Created by Jay Marcyes on 9/28/16.
#import "DDLog.h"


/**
 This just logs the Class.method as DEBUG log level, just something I do often enough
 */
#define DDLogMethod() LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagDebug, 0, nil, __PRETTY_FUNCTION__, @"%@(%p).%@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd))

