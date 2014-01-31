//
//  UIDevice+Extensions.h
//
//  Created by Derrick Walker on 9/17/12.
//  Copyright (c) 2012 Derrick Walker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Extensions)

+ (BOOL)hasExtendedScreen;
+ (BOOL)deviceIdiomIPAD;
+ (BOOL)deviceIdiomIPHONE;
+ (BOOL)hasRetinaDisplay;
+ (float)deviceVersion;
+ (BOOL)iOS7;

@end
