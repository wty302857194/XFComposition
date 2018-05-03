//
//  CreatcircleFourCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "CreatcircleFourCell.h"

@implementation CreatcircleFourCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 25)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"圈子名称：";
        [self.contentView addSubview:label];
        
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt.frame = CGRectMake(CGRectGetMaxX(label.frame), 10, 120, 35);
        self.bt.layer.borderWidth = 1;
        self.bt.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.bt.layer.cornerRadius = 4;
        self.bt.layer.masksToBounds = YES;
        [self.bt setTitle:@"阅读乐园" forState:UIControlStateNormal];
        [self.bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.bt.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.bt];
    }
    return self;
}

@end
