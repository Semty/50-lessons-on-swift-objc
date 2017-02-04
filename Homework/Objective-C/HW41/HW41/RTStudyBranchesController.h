//
//  RTStudyBranchesController.h
//  HW41
//
//  Created by Руслан on 29.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTStudyBranchesProtocol <NSObject>

@property (weak, nonatomic) IBOutlet UITextField *studyBranchesField;
@property (assign, nonatomic) NSInteger selectedRow;

@end

@interface RTStudyBranchesController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id<RTStudyBranchesProtocol> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *studyBranchesPicker;

@end
