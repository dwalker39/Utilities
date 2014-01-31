//
//  MapWrapper.m
//
//  Created by Derrick Walker on 2/21/12.
//  Copyright (c) 2012 Derrick Walker. All rights reserved.
//

#import "MapWrapper.h"

@implementation MapWrapper

#pragma mark -
#pragma mark Public Methods

+ (void)openInGoogleMaps:(NSString *)apQuery
{
    [ [UIApplication sharedApplication] openURL: [NSURL URLWithString: [NSString stringWithFormat:@"http://maps.apple.com/maps?q=%@", apQuery] ] ];
}

+ (void)openInGoogleMapsWithLatitude:(float)aLat andLongitude:(float)aLong
{
    [ [UIApplication sharedApplication] openURL: [NSURL URLWithString: [NSString stringWithFormat:@"http://maps.apple.com/maps?ll=%f,%f",aLat, aLong] ] ]; 
}

+ (void)openInGoogleMaps:(CLLocationCoordinate2D)aStartAddress withDestination:(CLLocationCoordinate2D)aDestination
{    
    NSString *vpMapsURLString = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%1.6f,%1.6f&daddr=%1.6f,%1.6f",
                                 aStartAddress.latitude, aStartAddress.longitude, aDestination.latitude, aDestination.longitude];
    
    [ [UIApplication sharedApplication] openURL: [NSURL URLWithString:vpMapsURLString] ];
}

@end
