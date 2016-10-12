//
//  ViewController.h
//  HW20
//
//  Created by Руслан on 12.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *chessTable;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *smallSquadsFirst;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *smallSquadsSecond;

@end

