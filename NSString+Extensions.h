//
//  NSString+Extensions.h
//
//  Created by Derrick Walker on 4/26/12.
//  Copyright (c) 2012 Derrick Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)

// Instance Methods
- (NSString *)stringByRemovingCharactersInString:(NSString *)apString;

// Class Methods
+ (NSString *)URLEncodeWithString:(NSString *)apSource;
+ (NSString *)URLEncodeWithStringUsingCoreFoundation:(NSString *)apSource;

@end
