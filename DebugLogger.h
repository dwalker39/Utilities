//
//  DebugLogger.h
//
//  Created by Derrick Walker on 5/9/13.
//

#import <Foundation/Foundation.h>

@interface DebugLogger : NSObject

/* Add the following code to Project-Prefix.pch */
#ifdef DEBUG
extern void DBLog(NSString *format, ...);
#define DLOG(fmt, ...) DBLog((@"[%@, Line: %d] " fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, ##__VA_ARGS__);
#else
#define DLOG(fmt, ...)
#endif

@end
