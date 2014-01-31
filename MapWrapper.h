//
//  MapWrapper.h
//
//  Created by Derrick Walker on 2/21/12.
//  Copyright (c) 2012 Derrick Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface MapWrapper : NSObject

+ (void)openInGoogleMaps:(NSString *)apQuery;
+ (void)openInGoogleMapsWithLatitude:(float)aLat andLongitude:(float)aLong;
+ (void)openInGoogleMaps:(CLLocationCoordinate2D)aStartAddress withDestination:(CLLocationCoordinate2D)aDestination;

@end
