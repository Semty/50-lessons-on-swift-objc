//
//  RTStudent.m
//  HW37-38
//
//  Created by Руслан on 08.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTStudent.h"

@interface RTStudent ()

@property (strong, nonatomic) NSString *birthday;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;

@property (assign, nonatomic) double longitude;
@property (assign, nonatomic) double latitude;

@end

@implementation RTStudent

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _name = firstNames[arc4random() % 56];
        _surname = lastNames[arc4random() % 56];
        
        double plusOrMinus = arc4random() % 2 == 0 ? -1 : 1;
        _longitude = ((double)(arc4random() % 5000) / 100000.f * plusOrMinus) + mainLongitude;
        plusOrMinus = arc4random() % 2 == 0 ? -1 : 1;
        _latitude = ((double)(arc4random() % 5000) / 100000.f * plusOrMinus) + mainLatitude;
        
        _coordinate.longitude = _longitude;
        _coordinate.latitude = _latitude;
        
        _title = [NSString stringWithFormat:@"%@ %@", _name, _surname];
        
        // 17 age = 536 112 000
        // 8  age = 252 288 000
        
        NSTimeInterval intervalBetween17and25Ages = arc4random() % 252288000 + 536112000;
        
        NSDate *dateOfBirthday = [[NSDate alloc] initWithTimeIntervalSinceNow:-intervalBetween17and25Ages];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MMMM, yyyy"];
        
        _birthday = [dateFormatter stringFromDate:dateOfBirthday];
        
        _subtitle = _birthday;
        
        _gender = arc4random() % 2 == 0 ? RTWoman : RTMan;
    }
    return self;
}

static double mainLatitude = 55.755308;
static double mainLongitude  = 37.646547;

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

@end
