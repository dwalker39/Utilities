//
//  NSString+Extensions.m
//
//  Created by Derrick Walker on 4/26/12.
//  Copyright (c) 2012 Derrick Walker. All rights reserved.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

+ (NSString *)URLEncodeWithString:(NSString *)apSource
{
    NSString *vpURLEncodedValue = nil;

    vpURLEncodedValue = [apSource stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return vpURLEncodedValue;
}

+ (NSString *)URLEncodeWithStringUsingCoreFoundation:(NSString *)apSource
{
    NSString *vpURLEncodedValue = nil;
#if __has_feature(objc_arc)
    vpURLEncodedValue = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                     (__bridge CFStringRef)apSource,
                                                                                     NULL,
                                                                                     (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                     kCFStringEncodingUTF8);
#else
    vpURLEncodedValue = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                            (CFStringRef)apSource,
                                                                            NULL,
                                                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                            kCFStringEncodingUTF8);
    
    [vpURLEncodedValue autorelease];
#endif
    
    return vpURLEncodedValue;
}

@end
