//
//  TiankongCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "TiankongCell.h"

@implementation TiankongCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}
-(void)setModel:(GetActivePageViewModel *)model{
    _model = model;
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.frame =CGRectMake(10, 10, 200, 20);
    [self.contentView addSubview:self.titleLabel];
    
    
    self.titleLabel.font = [UIFont systemFontOfSize:16];
//    self.titleLabel.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
//    self.titleLabel.font = [UIFont systemFontOfSize:16];
    
    UILabel *label = [[UILabel alloc]init];
    self.textfield = [[UITextField alloc]init];
    
    [self.contentView addSubview:label];
    [self.contentView addSubview:self.textfield];
    
    label.sd_layout.leftSpaceToView(self.contentView, 40).topSpaceToView(self.titleLabel, 20).widthIs(60).heightIs(30);
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"答案：";
    label.backgroundColor = [UIColor colorWithHexString:@"F3F4F3"];
    label.layer.borderWidth = 1;
    label.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.textfield.sd_layout.leftSpaceToView(label, 0).topEqualToView(label).rightSpaceToView(self.contentView, 20).heightIs(30);
    self.textfield.font = [UIFont systemFontOfSize:14];
    self.textfield.clearButtonMode=YES;
    self.textfield.leftViewMode=UITextFieldViewModeAlways;
    self.textfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.textfield.layer.borderWidth = 1;
//    [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
    
}
@end
