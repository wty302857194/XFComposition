//
//  LookStandarCell.m
//  XFComposition
//
//  Created by qiannian on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "LookStandarCell.h"

@implementation LookStandarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)reloadData:(FMBean*)bean{
    
    StandardInfo * info = (StandardInfo*)bean;
    
    _contentLabel.text = info.StandardText;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
