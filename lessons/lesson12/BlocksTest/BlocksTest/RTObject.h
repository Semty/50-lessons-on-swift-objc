//
//  RTObject.h
//  BlocksTest
//
//  Created by Руслан on 28.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void (^ObjectBlock)(void);

@interface RTObject : NSObject

@property (strong, nonatomic) NSString *name;

- (void) testMethod:(ObjectBlock)someBlock;

@end
