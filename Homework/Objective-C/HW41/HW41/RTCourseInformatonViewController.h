//
//  RTCourseInformatonViewController.h
//  HW41
//
//  Created by Руслан on 28.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTCoursesNameAndSubjectCell;
@class RTStudyBranchesCell;
@class RTTeacherCell;
@class RTCourseCell;
@class RTCourse;
@class RTLearningStudentCell;

@interface RTCourseInformatonViewController : UITableViewController

@property (strong, nonatomic) NSString *titleName;
@property (weak, nonatomic) RTCourseCell *editCell;
@property (weak, nonatomic) RTCourse *editCourse;

@property (weak, nonatomic) RTCoursesNameAndSubjectCell *nameCell;
@property (weak, nonatomic) RTCoursesNameAndSubjectCell *subjectCell;
@property (weak, nonatomic) RTStudyBranchesCell *studyBranchesCell;
@property (weak, nonatomic) RTTeacherCell *teacherCell;
@property (strong, nonatomic) NSMutableArray<RTLearningStudentCell *>* studentCells;

- (IBAction)actionSaveData:(UIBarButtonItem *)sender;

@end
