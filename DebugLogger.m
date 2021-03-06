//
//  DebugLogger.m
//
//  Created by Derrick Walker on 5/9/13.
//

#import "DebugLogger.h"

@implementation DebugLogger

#ifdef DEBUG
void DBLog(NSString *format, ...)
{
    if (format == nil)
    {
        printf("nil\n");
        return;
    }
    
    va_list argList;
    va_start(argList, format);
    
    NSString *s = [[NSString alloc] initWithFormat:format arguments:argList];
    printf("%s\n", [[s stringByReplacingOccurrencesOfString:@"%%" withString:@"%%%%"] UTF8String]);
    
#if ! __has_feature(objc_arc)
    [s release];
#endif
    
    va_end(argList);
}
#endif

@end
