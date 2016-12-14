//
//  RTMeetingPoint.m
//  HW37-38
//
//  Created by Руслан on 11.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTMeetingPoint.h"

@interface RTMeetingPoint ()

@property (assign, nonatomic) double longitude;
@property (assign, nonatomic) double latitude;

@end

@implementation RTMeetingPoint

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        double plusOrMinus = arc4random() % 2 == 0 ? -1 : 1;
        _longitude = ((double)(arc4random() % 5000) / 100000.f * plusOrMinus) + mainLongitude;
        plusOrMinus = arc4random() % 2 == 0 ? -1 : 1;
        _latitude = ((double)(arc4random() % 5000) / 100000.f * plusOrMinus) + mainLatitude;
        
        _coordinate.longitude = _longitude;
        _coordinate.latitude = _latitude;
        
        _title = @"Meeting";
    }
    return self;
}

static double mainLatitude = 55.755308;
static double mainLongitude  = 37.646547;

@end
