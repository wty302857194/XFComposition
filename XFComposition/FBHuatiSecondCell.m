//
//  FBHuatiSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "FBHuatiSecondCell.h"

@implementation FBHuatiSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 60, 35)];
        
        label1.text = @"分类：";
        label1.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label1];
        self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 10, WidthFrame-100, 35)];
        self.textfield.layer.borderWidth = 1.5;
        self.textfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.textfield.layer.cornerRadius = 6;
        self.textfield.layer.masksToBounds = YES;
        self.textfield.clearButtonMode=YES;
        self.textfield.font = [UIFont systemFontOfSize:14];
        self.textfield.leftViewMode=UITextFieldViewModeAlways;
        [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
        self.textfield.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.textfield];
        
        
        
    }
    return self;
    
}

@end
