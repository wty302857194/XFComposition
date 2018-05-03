//
//  CreatcircleFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "CreatcircleFristCell.h"

@implementation CreatcircleFristCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 35)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"圈子名称：";
        [self.contentView addSubview:label];
        self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 10, WidthFrame-165, 35)];
        self.textfield.layer.borderWidth = 1;
        self.textfield.placeholder = @"请输入圈子名称";
        self.textfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.textfield.layer.cornerRadius = 6;
        self.textfield.layer.masksToBounds = YES;
        self.textfield.clearButtonMode=YES;
        self.textfield.leftViewMode=UITextFieldViewModeAlways;
        [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
        self.textfield.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.textfield];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.textfield.frame)+5, 15, 40, 25)];
        label2.layer.cornerRadius = 4;
        label2.layer.masksToBounds = YES;
        label2.backgroundColor = [UIColor colorWithHexString:@"F3A932"];
        label2.text = @"必填";
        label2.textAlignment = NSTextAlignmentCenter;
        label2.textColor = [UIColor whiteColor];
        label2.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:label2];
        
        
        
    }
    return self;
}

@end
