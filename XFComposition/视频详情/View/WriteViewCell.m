//
//  WriteViewCell.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/11.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "WriteViewCell.h"

@implementation WriteViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataModel:(CommwritelistModel *)dataModel
{
    _dataModel = dataModel;
    _nameLab.text = _dataModel.BlogTitle;
    _dateLab.text = _dataModel.BlogAddTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
