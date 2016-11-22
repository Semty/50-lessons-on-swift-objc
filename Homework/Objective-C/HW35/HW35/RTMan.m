//
//  RTStudent.m
//  HW35
//
//  Created by Руслан on 21.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTMan.h"

@implementation RTMan

static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie", @"Akram",
    @"Ruslan", @"Dasha", @"Sergey", @"Sveta", @"Zahar"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook", @"Timchenko",
    @"Makhmudov(a)", @"Astapenkov(a)", @"Kobilkin(a)", @"Tarasov(a)",
    @"Glushko"
};

static int namesCount = 56;

+ (RTMan *) randomMan {
    
    RTMan *man = [[RTMan alloc] init];
    
    NSTimeInterval intervalOf46Years = arc4random() % 1450656000;
    NSDate *birthday = [[NSDate alloc] initWithTimeIntervalSince1970:intervalOf46Years];
    
    man.firstName = firstNames[arc4random() % namesCount];
    man.lastName = lastNames[arc4random() % namesCount];
    man.birthday = birthday;
    
    return man;
}

+ (NSArray *) randomPeopleWithNumber:(NSInteger)number {
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSMutableArray *duplicateNames = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < number; i++) {
        
        RTMan *man = [self randomMan];
        NSString *fullname = [man.firstName stringByAppendingString:man.lastName];
        
        while ([self isDuplicate:duplicateNames :fullname]) {
            man = [self randomMan];
            fullname = [man.firstName stringByAppendingString:man.lastName];
        }
        [tempArray addObject:man];
        [duplicateNames addObject:fullname];
    }
    return tempArray;
}

+ (BOOL) isDuplicate:(NSArray *)duplicates :(NSString *)duplicate {
    
    for (NSString *tempDuplicate in duplicates) {
        
        if ([tempDuplicate isEqualToString:duplicate]) {
            return YES;
        }
    }
    return NO;
}

@end
