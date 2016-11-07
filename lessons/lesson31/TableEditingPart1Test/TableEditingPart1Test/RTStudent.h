//
//  RTStudent.h
//  TableEditingPart1Test
//
//  Created by Руслан on 07.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RTStudent : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) CGFloat averageGrade;

+ (RTStudent *) randomStudent;

@end
