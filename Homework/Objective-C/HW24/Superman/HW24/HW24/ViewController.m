//
//  ViewController.m
//  HW24
//
//  Created by Руслан on 22.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) BOOL swiped;

@property (weak, nonatomic) IBOutlet DrawingView *mainDrawingView;
@property (weak, nonatomic) IBOutlet DrawingView *tempDrawingView;
@property (weak, nonatomic) IBOutlet DrawingView *viewBrush;

@property (weak, nonatomic) IBOutlet UILabel *redColorValue;
@property (weak, nonatomic) IBOutlet UILabel *greenColorValue;
@property (weak, nonatomic) IBOutlet UILabel *blueColorValue;
@property (weak, nonatomic) IBOutlet UILabel *opacityValue;
@property (weak, nonatomic) IBOutlet UILabel *brushValue;

@property (weak, nonatomic) IBOutlet UISlider *redColorSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenColorSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueColorSlider;
@property (weak, nonatomic) IBOutlet UISlider *opacitySlider;
@property (weak, nonatomic) IBOutlet UISlider *brushSizeSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainDrawingView.delegate = self;
    self.tempDrawingView.delegate = self;
    self.viewBrush.delegate = self;
    
    [self refreshValues];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpful functions

- (void) touchEndedOrCancelled {
    
    if (!self.swiped) {
        [self.tempDrawingView drawLineFrom:self.lastPoint to:self.lastPoint];
        
    }
    [self.tempDrawingView mergeTempView:self.tempDrawingView intoMainView:self.mainDrawingView];
}

#pragma mark - Touches

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.swiped = NO;
    
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.tempDrawingView];
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.swiped = YES;
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.tempDrawingView];
    
    [self.tempDrawingView drawLineFrom:self.lastPoint to:currentPoint];
    self.lastPoint = currentPoint;
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchEndedOrCancelled];
}



#pragma mark - Actions

- (IBAction)changeValueSlider:(id)sender {
    [self refreshValues];
}

- (IBAction)erase:(id)sender {
    
    self.redColorSlider.value = 1.f;
    self.greenColorSlider.value = 1.f;
    self.blueColorSlider.value = 1.f;
    self.opacitySlider.value = 1.f;
    
    [self refreshValues];
}

- (IBAction)reset:(id)sender {
    self.mainDrawingView.image = nil;
}

#pragma mark - Refresh values

- (void) refreshValues {
    
    self.redColor = self.redColorSlider.value;
    self.redColorValue.text = [NSString stringWithFormat:@"%d", (int)(self.redColor*255)];
    
    self.greenColor = self.greenColorSlider.value;
    self.greenColorValue.text = [NSString stringWithFormat:@"%d", (int)(self.greenColor*255)];
    
    self.blueColor = self.blueColorSlider.value;
    self.blueColorValue.text = [NSString stringWithFormat:@"%d", (int)(self.blueColor*255)];
    
    self.opacity = self.opacitySlider.value;
    self.opacityValue.text = [NSString stringWithFormat:@"%1.1f", self.opacity];
    
    self.lineWidth = self.brushSizeSlider.value*100;
    self.brushValue.text = [NSString stringWithFormat:@"%1.1f", self.lineWidth];
    
    [self.viewBrush drawPreview];
}

@end
