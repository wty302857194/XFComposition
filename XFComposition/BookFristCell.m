//
//  BookFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookFristCell.h"

@implementation BookFristCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 80, 30)];
        self.label.font = [UIFont systemFontOfSize:15];
        self.label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.label];
        
        self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(100, 5, WidthFrame-120, 30)];
//        self.textfield.layer.borderWidth = 1;
//        self.textfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//        self.textfield.layer.cornerRadius = 6;
//        self.textfield.layer.masksToBounds = YES;
        self.textfield.clearButtonMode=YES;
        self.textfield.font = [UIFont systemFontOfSize:14];
//        self.textfield.leftViewMode=UITextFieldViewModeAlways;
//        [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
        [self.contentView addSubview:self.textfield];
    }
    return self;
}
@end
