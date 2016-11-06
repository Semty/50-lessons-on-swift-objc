//
//  RTStudent.m
//  HW30
//
//  Created by Руслан on 06.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTStudent.h"

@interface RTStudent ()

@end

@implementation RTStudent

#pragma mark - Initialization

- (instancetype)initWithFullNameAndAvMark
{
    self = [super init];
    if (self) {
        
        self.firstName = self.randomFirstName;
        self.lastName = self.randomLastName;
        self.fullName = [NSString stringWithFormat:@"%@ %@", self.lastName, self.firstName];
        self.averageMark = self.randomMark;
        
    }
    return self;
}

#pragma mark - Methods

- (NSString *) randomFirstName {
    
    NSInteger randomFirstName = arc4random() % 11;
    
    switch (randomFirstName) {
        case 0:
            return @"Ruslan";
            break;
        case 1:
            return @"Akram";
            break;
        case 2:
            return @"Zahar";
            break;
        case 3:
            return @"Sveta";
            break;
        case 4:
            return @"Dasha";
            break;
        case 5:
            return @"Sergey";
            break;
        case 6:
            return @"Igor";
            break;
        case 7:
            return @"Natasha";
            break;
        case 8:
            return @"Marina";
            break;
        case 9:
            return @"Misha";
            break;
        case 10:
            return @"Grisha";
            break;
        default:
            return @"Default";
    }
}

- (NSString *) randomLastName {
    
    NSInteger randomLastName = arc4random() % 11;
    
    switch (randomLastName) {
        case 0:
            return @"Timchenko";
            break;
        case 1:
            return @"Makhmudov(a)";
            break;
        case 2:
            return @"Ostapenko";
            break;
        case 3:
            return @"Shilov(a)";
            break;
        case 4:
            return @"Minkh";
            break;
        case 5:
            return @"Trusov(a)";
            break;
        case 6:
            return @"Kin";
            break;
        case 7:
            return @"Monorov(a)";
            break;
        case 8:
            return @"Trebov(a)";
            break;
        case 9:
            return @"Padavannov(a)";
            break;
        case 10:
            return @"Amov(a)";
            break;
        default:
            return @"Default";
    }
}

- (float) randomMark {
    
    float randomMark = ((float)(arc4random() % 30) + 20.f) / 10.f;
    
    return randomMark;
}

@end









