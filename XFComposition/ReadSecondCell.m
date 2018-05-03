//
//  ReadSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadSecondCell.h"

@implementation ReadSecondCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (WidthFrame-20-30)/4, HeightFrame/6)];
        
        [self.contentView addSubview:self.imgView];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightFrame/6, (WidthFrame-20-30)/4, 20)];
//        self.nameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.numberOfLines=0;
        self.nameLabel.text = @"2233";
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:11];
        
//        self.nameLabel.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, HeightFrame/6+5).widthIs((WidthFrame-20-30)/4).autoHeightRatio(0);
        
        
    }
    return self;
}
@end
