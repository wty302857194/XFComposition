//
//  MarkProgressSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MarkProgressSecondCell.h"

@implementation MarkProgressSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 25)];
        label2.text = @"笔记标题：";
        label2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label2];
        self.titleTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), 10, WidthFrame-120, 25)];
        self.titleTextfield.layer.borderWidth = 1;
        self.titleTextfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.titleTextfield.layer.cornerRadius = 5;
        self.titleTextfield.font = [UIFont systemFontOfSize:14];
        self.titleTextfield.layer.masksToBounds = YES;
        self.titleTextfield.leftViewMode=UITextFieldViewModeAlways;
        [self.titleTextfield setBorderStyle:UITextBorderStyleRoundedRect];
        self.titleTextfield.keyboardType = UIKeyboardTypeNumberPad;
        [self.contentView addSubview:self.titleTextfield];
    }
    return self;
    
}

@end
