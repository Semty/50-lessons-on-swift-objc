//
//  RTStudent.m
//  HW40
//
//  Created by Руслан on 19.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTStudent.h"

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

@implementation RTStudent

#pragma mark - Override initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _firstName = firstNames[arc4random_uniform(namesCount)];
        _lastName = lastNames[arc4random_uniform(namesCount)];
        _grade = arc4random_uniform(201) / 100.f + 2.f;
        _dateOfBirth = [[NSDate alloc] initWithTimeIntervalSince1970:arc4random_uniform(1450656000)];
        _gender = arc4random_uniform(2) == 0 ? RTMan : RTWoman;
        
    }
    return self;
}

#pragma mark - Reset Functions

- (void) resetAllProperties {

    [self willChangeValueForKey:@"firstName"];
    [self willChangeValueForKey:@"lastName"];
    [self willChangeValueForKey:@"dateOfBirth"];
    [self willChangeValueForKey:@"grade"];
    [self willChangeValueForKey:@"gender"];
    
    _firstName = nil;
    _lastName = nil;
    _dateOfBirth = nil;
    _gender = RTMan;
    _grade = 2.5;
    
    [self didChangeValueForKey:@"firstName"];
    [self didChangeValueForKey:@"lastName"];
    [self didChangeValueForKey:@"dateOfBirth"];
    [self didChangeValueForKey:@"grade"];
    [self didChangeValueForKey:@"gender"];
}

#pragma mark - Override undefined keys

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"!!! setValueForUndefinedKey = %@ !!!", key);
}

- (instancetype) valueForUndefinedKey:(NSString *)key {
    NSLog(@"!!! valueForUndefinedKey = %@ !!!", key);
    return nil;
}

@end
