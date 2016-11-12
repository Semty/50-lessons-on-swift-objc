//
//  RTFootballClub.h
//  HW31-32
//
//  Created by Руслан on 12.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    
    AddingNewClub,
    DeleteLeague
    
} RTAction;

@interface RTFootballClub : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *league;
@property (assign, nonatomic) NSInteger points;

+ (RTFootballClub *) randomFootballClub;
+ (NSArray *) randomFootballLeague;
+ (RTFootballClub *) makeDefaultClubWithAction:(RTAction)action;
+ (NSArray *) makeEmptyLeague;

@end
