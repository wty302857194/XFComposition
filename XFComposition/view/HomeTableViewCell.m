//
//  HomeTableViewCell.m
//  XFComposition
//
//  Created by wbb on 2018/4/17.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeLessonModel.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setLessonModel:(HomeLessonModel *)lessonModel
{
    _lessonModel = lessonModel;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTurl,lessonModel.MicroclassInfoAttr1?:@""]] placeholderImage:[UIImage imageNamed:@"xf_Norecord"]];
    self.titleLab.text = lessonModel.MicroclassInfoTitle?:@"";
    self.nameLab.text = [NSString stringWithFormat:@"课程设计导师：%@",lessonModel.MicroclassInfoMaster?:@""];
}

@end
