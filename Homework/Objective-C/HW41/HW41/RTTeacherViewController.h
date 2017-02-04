//
//  RTTeacherViewController.h
//  HW41
//
//  Created by Руслан on 29.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTStudent;

@protocol RTTeacherProtocol <NSObject>

@property (weak, nonatomic) IBOutlet UITextField *teacherField;
@property (weak, nonatomic) RTStudent *teacher;
@property (assign, nonatomic) NSInteger selectedRow;

@end

@interface RTTeacherViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id<RTTeacherProtocol> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *teacherPicker;

@end
