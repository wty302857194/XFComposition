//
//  RealnameFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RealnameFristCell.h"

@implementation RealnameFristCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imgView = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        self.titleLabel = [[UILabel alloc]init];
        
        [self.contentView sd_addSubviews:@[imgView,label,self.titleLabel]];
        
        
        imgView.sd_layout.leftSpaceToView(self.contentView, 20).centerYEqualToView(self.contentView).heightIs(5).widthIs(5);
        imgView.image = [UIImage imageNamed:@"pic_star"];
        
        
        label.sd_layout.leftSpaceToView(imgView, 5).topSpaceToView(self.contentView, 5).heightIs(30).widthIs(105);
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"用户名";
        label.font  = [UIFont systemFontOfSize:14];
//        [label setSingleLineAutoResizeWithMaxWidth:0];
        
        
        self.titleLabel.sd_layout.leftSpaceToView(label, 0).centerYEqualToView(label).rightSpaceToView(self.contentView, 20).heightIs(30);
        self.titleLabel.font  = [UIFont systemFontOfSize:14];
        
        
        
    }
    return self;
}

@end
