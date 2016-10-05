//  Created by Jay Marcyes on 9/28/16.
#import "DDLog.h"


// DEPRECATED 10-2-2016, use the DDLogMethodDebug macro, turns out I wanted to do the
// same thing on verbose also, so this has been expanded into 2 different macros
#define DDLogMethod() LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagDebug, 0, nil, __PRETTY_FUNCTION__, @"%@(%p).%@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd))


/**
 This just logs the Class.method as DEBUG log level, just something I do often enough
 */
#define DDLogMethodDebug() LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagDebug, 0, nil, __PRETTY_FUNCTION__, @"%@(%p).%@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd))


/**
 This just logs the Class.method as VERBOSE log level, just something I do often enough
 */
#define DDLogMethodVerbose() LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagVerbose, 0, nil, __PRETTY_FUNCTION__, @"%@(%p).%@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd))
