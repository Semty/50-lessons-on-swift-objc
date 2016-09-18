//
//  Patient.h
//  ProtocolsTest
//
//  Created by Руслан on 18.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Patient <NSObject>

@required

@property (strong, nonatomic) NSString* name;

- (BOOL) areYouOk;
- (void) takePill;
- (void) makeShot;

@optional

- (NSString*) howIsYourFamily;
- (NSString*) howIsYourJob;

@end
