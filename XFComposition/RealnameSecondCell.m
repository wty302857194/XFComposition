//
//  RealnameSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RealnameSecondCell.h"

@implementation RealnameSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imgView = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        self.Textfield = [[UITextField alloc]init];
        [self.contentView sd_addSubviews:@[imgView,label,self.Textfield]];
        
        
        imgView.sd_layout.leftSpaceToView(self.contentView, 20).centerYEqualToView(self.contentView).heightIs(5).widthIs(5);
        imgView.image = [UIImage imageNamed:@"pic_star"];
        
        
        label.sd_layout.leftSpaceToView(imgView, 5).topSpaceToView(self.contentView, 5).heightIs(30).widthIs(105);
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"真实姓名";
        label.font  = [UIFont systemFontOfSize:14];
//        [label setSingleLineAutoResizeWithMaxWidth:0];
        
        
        self.Textfield.sd_layout.leftSpaceToView(label, 0).centerYEqualToView(label).rightSpaceToView(self.contentView, 20).heightIs(30);
//        self.Textfield.text = @"teacher2";
        self.Textfield.font  = [UIFont systemFontOfSize:14];
        self.Textfield.layer.cornerRadius = 4;
        self.Textfield.layer.masksToBounds = YES;
        self.Textfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.Textfield.layer.borderWidth = 1;
        self.Textfield.clearButtonMode=YES;
        self.Textfield.leftViewMode=UITextFieldViewModeAlways;
        [self.Textfield setBorderStyle:UITextBorderStyleNone];
        
    }
    return self;
}



@end
