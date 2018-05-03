//
//  SecondCollectionViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/29.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "SecondCollectionViewCell.h"

@implementation SecondCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth  = 0.5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];

        self.backgroundColor = [UIColor whiteColor];
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,WidthFrame/2-30, HeightFrame/6-30)];
        self.imageView.layer.borderWidth= 0.5;
        self.imageView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        self.imageView.layer.cornerRadius = 6;
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        
//        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView.frame)+10, (WidthFrame/2-10)-20, 20)];
        self.titleLabel = [[UILabel alloc]init];
        [self addSubview:self.titleLabel];
        self.titleLabel.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self.imageView, 5).heightIs(20);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:0];
        
        self.titleLabel.text = @"深入大别山";

        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.textColor = UIColorFromRGBA(55, 180, 255, 1.0f);
        
    }
    return  self;
}

@end
