//
//  CourseOutlineCell.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "CourseOutlineCell.h"

@implementation CourseOutlineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setVideoModel:(MicroVideoModel *)videoModel atIndex:(NSInteger)index
{
    _titleLab.text = [NSString stringWithFormat:@"%zd《%@》",index,videoModel.title];
    _classLab.text = [NSString stringWithFormat:@"课时 %zd",index];
    _totalTimeLab.text = [NSString stringWithFormat:@"时长 【%@】",videoModel.playlength];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
