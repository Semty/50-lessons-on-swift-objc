//
//  ViewController.m
//  ButtonsTest
//
//  Created by Руслан on 24.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(100, 100, 150, 50);
    button.backgroundColor = [UIColor lightGrayColor];
    
    
     NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:30],
     NSForegroundColorAttributeName: [UIColor yellowColor] };
     NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Button"
     attributes:attributes];
     [button setAttributedTitle:title forState:UIControlStateNormal];
     
     
     NSDictionary *attributesPressed = @{ NSFontAttributeName: [UIFont systemFontOfSize:20],
     NSForegroundColorAttributeName: [UIColor blackColor] };
     NSAttributedString *titlePressed = [[NSAttributedString alloc] initWithString:@"Button pressed"
     attributes:attributesPressed];
     [button setAttributedTitle:titlePressed forState:UIControlStateHighlighted];
     
    
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button setTitle:@"Button pressed" forState:UIControlStateHighlighted];
    
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.f green:0.f blue:0.7f alpha:0.5f]
                 forState:UIControlStateHighlighted];
    
    //UIEdgeInsets insets = UIEdgeInsetsMake(20, 0, 0, 0);
    //button.titleEdgeInsets = insets;
    
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(actionTest:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [button addTarget:self action:@selector(actionTestOutside:)
     forControlEvents:UIControlEventTouchUpOutside];
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) actionTest:(UIButton *)button {
    
    NSLog(@"Button pressed inside!");
    
}

- (void) actionTestOutside:(UIButton *)button {
    
    NSLog(@"Button pressed outside!");
    
}

- (IBAction)actionTest2:(UIButton *)sender {
    
    NSLog(@"Button%ld pressed inside!", sender.tag);
    
    self.indicatorLabel.text = [NSString stringWithFormat:@"%ld", sender.tag];
}

- (IBAction)actionTest2TouchDown:(UIButton *)sender {
    
    NSLog(@"Button%ld touch down!", sender.tag);
    
    self.indicatorLabel.text = [NSString stringWithFormat:@"%ld", sender.tag];
    
}

@end
