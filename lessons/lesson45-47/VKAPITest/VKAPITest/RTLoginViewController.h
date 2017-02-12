//
//  RTLoginViewController.h
//  VKAPITest
//
//  Created by Руслан on 12.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTAccessToken;

typedef void(^RTLoginComplitionBlock)(RTAccessToken *accessToken);

@interface RTLoginViewController : UIViewController

- (instancetype) initWithComplitionBlock:(RTLoginComplitionBlock)complitionBlock;

@end
