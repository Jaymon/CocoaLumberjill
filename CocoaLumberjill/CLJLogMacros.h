//  Created by Jay Marcyes on 9/28/16.
#import "DDLog.h"


#define DDLogMethod() LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagDebug, 0, nil, __PRETTY_FUNCTION__, @"%@.%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))

