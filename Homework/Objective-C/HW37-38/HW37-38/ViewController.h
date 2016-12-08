//
//  ViewController.h
//  HW37-38
//
//  Created by Руслан on 08.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)actionShowAll:(UIBarButtonItem *)sender;

@end

