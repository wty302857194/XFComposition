//
//  StrokeViewCell.m
//  XFComposition
//
//  Created by qiannian on 2018/5/15.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "StrokeViewCell.h"

@implementation StrokeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)reloadData:(FMBean *)bean{
    StandardInfo * info = (StandardInfo*)bean;
    if (info.isSelected) {
        _imgeView.image = [UIImage imageNamed:@"thumbImage"];
    }else{
        
        _imgeView.image = [UIImage imageNamed:@"normalIcon"];

    }
    _titleLabel.text = info.StandardText;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
