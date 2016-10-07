//
//  RTStudent.m
//  HW16
//
//  Created by Руслан on 07.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTStudent.h"

@implementation RTStudent

- (instancetype)initWithAlias:(NSString *)someAlias
{
    self = [super init];
    if (self) {
        self.studentAlias = someAlias;
    }
    return self;
}

- (void) createName {
    
    NSUInteger code = arc4random() % 15;
    
    switch (code) {
        case 0:
            self.name = @"Jack";
            break;
        case 1:
            self.name = @"Mariya";
            break;
        case 2:
            self.name = @"Alex";
            break;
        case 3:
            self.name = @"Ruslan";
            break;
        case 4:
            self.name = @"Eduard";
            break;
        case 5:
            self.name = @"Erik";
            break;
        case 6:
            self.name = @"Misha";
            break;
        case 7:
            self.name = @"Akram";
            break;
        case 8:
            self.name = @"Zahar";
            break;
        case 9:
            self.name = @"Dasha";
            break;
        case 10:
            self.name = @"Ann";
            break;
        case 11:
            self.name = @"Svetlana";
            break;
        case 12:
            self.name = @"Gleb";
            break;
        case 13:
            self.name = @"Dan";
            break;
        case 14:
            self.name = @"Nastya";
            break;
    }
}

- (void) createSurname {
    
    NSUInteger code = arc4random() % 15;
    
    switch (code) {
        case 0:
            self.surname = @"Timchenko";
            break;
        case 1:
            self.surname = @"Makhmudov(a)";
            break;
        case 2:
            self.surname = @"Nugamanov(a)";
            break;
        case 3:
            self.surname = @"Smith";
            break;
        case 4:
            self.surname = @"Blazhic";
            break;
        case 5:
            self.surname = @"Contana";
            break;
        case 6:
            self.surname = @"Tarasov(a)";
            break;
        case 7:
            self.surname = @"Maksimenko";
            break;
        case 8:
            self.surname = @"Gregorovich";
            break;
        case 9:
            self.surname = @"Stock";
            break;
        case 10:
            self.surname = @"Menex";
            break;
        case 11:
            self.surname = @"Kolomov(a)";
            break;
        case 12:
            self.surname = @"Evtushenko";
            break;
        case 13:
            self.surname = @"Kobilkin(a)";
            break;
        case 14:
            self.surname = @"Black";
            break;
    }
}

- (void) createDateOfBirth {
    
    double someNumber = (arc4random() % 1072224000) + 504576000;
    NSDateFormatter *someFormatter = [[NSDateFormatter alloc] init];
    [someFormatter setDateFormat:@"dd.MM.yyyy"];
    
    NSDate *startDate = [someFormatter dateFromString:@"01.11.2016"];
    
    NSDate *randomDate = [NSDate dateWithTimeInterval:-someNumber sinceDate:startDate];
    
    self.dateOfBirth = randomDate;
}

@end
