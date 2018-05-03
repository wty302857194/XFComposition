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
        
        
        label.sd_layout.rightSpaceToView(self.contentView, WidthFrame -120).topSpaceToView(self.contentView, 5).heightIs(30).widthIs(0);
        
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"用户名：";
        label.font  = [UIFont systemFontOfSize:14];
        [label setSingleLineAutoResizeWithMaxWidth:0];
        imgView.sd_layout.rightSpaceToView(label, 0).topSpaceToView(self.contentView, 15).heightIs(10).widthIs(10);
        imgView.backgroundColor = [UIColor lightGrayColor];
        self.titleLabel.sd_layout.leftSpaceToView(label, 0).topSpaceToView(self.contentView, 5).heightIs(30).widthIs(0);
        
//        self.titleLabel.text = @"teacher2";
        self.titleLabel.font  = [UIFont systemFontOfSize:14];
        
        
        
    }
    return self;
}

@end
