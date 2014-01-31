//
//  DXLogger.h
//
//  Created by Derrick Walker on 5/9/13.
//  Copyright (c) 2013 Derrick Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXLogger : NSObject

/* Add the following code to Project-Prefix.pch */
#ifdef DEBUG
extern void DXLog(NSString *format, ...);
#define DLOG(fmt, ...) DXLog((@"[%@, Line: %d] " fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, ##__VA_ARGS__);
#else
#define DLOG(fmt, ...)
#endif

@end
