//
//  CourseCollectionViewCell.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/9.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "CourseCollectionViewCell.h"
#import "SDWebImageManager.h"

@implementation CourseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataModel:(WriteListModel *)dataModel
{
    _dataModel = dataModel;
    NSString *str =[NSString stringWithFormat:@"%@%@",HTurl,_dataModel.MicroclassInfoAttr1];
    [_courseImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTurl,_dataModel.MicroclassInfoAttr1]] placeholderImage:[UIImage imageNamed:@"icon_02"]];
    _courseLab.text = _dataModel.MicroclassInfoTitle;
    
}

@end
