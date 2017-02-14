//
//  RTPostCell.m
//  VKAPITest
//
//  Created by Руслан on 14.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTPostCell.h"

@implementation RTPostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat) heightForText:(NSString *)text {
    
    UIFont *font = [UIFont systemFontOfSize:17.f];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    
    [shadow setShadowOffset:CGSizeMake(0, -1)];
    [shadow setShadowBlurRadius:0.5f];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraph setAlignment:NSTextAlignmentLeft];
    
    NSDictionary *attributes = @{ NSFontAttributeName           : font,
                                  NSParagraphStyleAttributeName : paragraph,
                                  NSShadowAttributeName         : shadow    };
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(359, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    
    return CGRectGetHeight(rect) + 25.f;
}

@end






