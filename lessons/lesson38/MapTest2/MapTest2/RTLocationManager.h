//
//  RTLocationManager.h
//  MapTest2
//
//  Created by Руслан on 05.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface RTLocationManager : CLLocationManager

- (void) checkAuthorizationLocation;

@end
