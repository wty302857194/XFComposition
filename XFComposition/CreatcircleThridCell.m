//
//  CreatcircleThridCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "CreatcircleThridCell.h"

@implementation CreatcircleThridCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 25)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"圈子封面：";
        [self.contentView addSubview:label];
        
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt.frame = CGRectMake(CGRectGetMaxX(label.frame), 10, 80, 80);
        self.bt.layer.backgroundColor = [[UIColor lightGrayColor] CGColor];
        self.bt.layer.borderWidth = 0.5;
        [self.contentView addSubview:self.bt];
        
    }
    return self;
}

@end
