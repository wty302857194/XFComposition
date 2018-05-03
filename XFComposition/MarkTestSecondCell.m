//
//  MarkTestSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MarkTestSecondCell.h"

@implementation MarkTestSecondCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = 0.5;
        self.titleLabel = [[UILabel alloc]init];
        self.textfield = [[UITextField alloc]init];
        [self.contentView sd_addSubviews:@[self.titleLabel,self.textfield]];
        
        self.titleLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).heightIs(35).widthIs(80);
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor colorWithHexString:@"F3F4F3"];
        
        
        self.textfield.sd_layout.leftSpaceToView(self.titleLabel, 0).topSpaceToView(self.contentView, 0).heightIs(35).widthIs(WidthFrame-80-80);
        self.textfield.clearButtonMode=YES;
        self.textfield.leftViewMode=UITextFieldViewModeAlways;
        //        [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
        self.textfield.font = [UIFont systemFontOfSize:14];

    }
    return self;
}
@end
