//
//  RealnameFourCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RealnameFourCell.h"

@implementation RealnameFourCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.label = [[UILabel alloc]init];
        self.textField = [[UITextField alloc]init];
        [self.contentView sd_addSubviews:@[self.label,self.textField]];
        
        
        self.label.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 5).heightIs(30).widthIs(115);
        self.label.textAlignment = NSTextAlignmentLeft;
        self.label.font  = [UIFont systemFontOfSize:14];

        
        self.textField.sd_layout.leftSpaceToView(self.label, 0).centerYEqualToView(self.label).rightSpaceToView(self.contentView, 20).heightIs(30);
        
//        self.textField.text = @"teacher2";
        self.textField.font  = [UIFont systemFontOfSize:14];
        self.textField.layer.cornerRadius = 4;
        self.textField.layer.masksToBounds = YES;
        self.textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.textField.layer.borderWidth = 1;
        self.textField.clearButtonMode=YES;
        self.textField.leftViewMode=UITextFieldViewModeAlways;
        [self.textField setBorderStyle:UITextBorderStyleNone];
    }
    return self;
}

@end
