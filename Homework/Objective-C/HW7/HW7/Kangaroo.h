//
//  Kangaroo.h
//  HW7
//
//  Created by Руслан on 18.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Runners.h"
#import "Jumpers.h"

@interface Kangaroo : NSObject <Runners, Jumpers>

@property (strong, nonatomic) NSString* name;

@end
