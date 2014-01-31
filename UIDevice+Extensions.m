//
//  UIDevice+Extensions.m
//
//  Created by Derrick Walker on 9/17/12.
//  Copyright (c) 2012 Derrick Walker. All rights reserved.
//

#import "UIDevice+Extensions.h"

@implementation UIDevice (Extensions)

+ (BOOL)hasExtendedScreen
{
    if ( [[UIScreen mainScreen] bounds].size.height > 480.f )
    {
        return YES;
    }

    return NO;
}

+ (BOOL)deviceIdiomIPAD
{
    return [(NSString *)[[UIDevice currentDevice] model] hasPrefix:@"iPad"];
}

+ (BOOL)deviceIdiomIPHONE
{
    NSString *vpModel = (NSString *)[[UIDevice currentDevice] model];
    
    return ( [vpModel hasPrefix:@"iPhone"] || [vpModel hasPrefix:@"iPod"] );
}

+ (BOOL)hasRetinaDisplay
{
    return [[UIScreen mainScreen] scale] == 2.0f;
}

+ (float)deviceVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (BOOL)iOS7
{
    return [self deviceVersion] >= 7.f;
}

@end
