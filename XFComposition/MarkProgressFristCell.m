//
//  MarkProgressFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MarkProgressFristCell.h"

@implementation MarkProgressFristCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 25)];
        
        label1.text = @"所读页数：";
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.pageTextfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 10, WidthFrame/4, 25)];
        self.pageTextfield.layer.borderWidth = 1;
        self.pageTextfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.pageTextfield.layer.cornerRadius = 5;
        self.pageTextfield.layer.masksToBounds = YES;
        self.pageTextfield.clearButtonMode=YES;
        self.pageTextfield.font = [UIFont systemFontOfSize:14];
        self.pageTextfield.leftViewMode=UITextFieldViewModeAlways;
        [self.pageTextfield setBorderStyle:UITextBorderStyleRoundedRect];
        self.pageTextfield.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.pageTextfield];
        self.pageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pageTextfield.frame), 10, WidthFrame/4*3-130, 25)];
        self.pageLabel.font = [UIFont systemFontOfSize:12];
//        self.pageLabel.text = [NSString stringWithFormat:@"（总页数：%@）",self.PageStr];
        [self.contentView addSubview:self.pageLabel];
        


    }
    return self;

}
@end
