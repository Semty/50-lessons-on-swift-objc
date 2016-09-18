//
//  Developer.h
//  ProtocolsTest
//
//  Created by Руслан on 18.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@interface Developer : NSObject <Patient>

@property (assign, nonatomic) float expirience;
@property (strong, nonatomic) NSString* name;

- (void) work;

@end
