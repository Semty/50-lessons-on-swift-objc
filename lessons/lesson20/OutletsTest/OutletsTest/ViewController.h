//
//  ViewController.h
//  OutletsTest
//
//  Created by Руслан on 12.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


//@property (weak, nonatomic) IBOutlet UIView *testView;
//@property (weak, nonatomic) IBOutlet UIView *testView2;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *testViews;


@end

