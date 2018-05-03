//
//  MicoThridCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicoThridCell.h"

@implementation MicoThridCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        
//        self.layer.cornerRadius = 6;
//        self.layer.masksToBounds = YES;
//        self.layer.borderWidth = 0.5;
//        self.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (WidthFrame-40-40)/3, HeightFrame/8)];
        self.imageView.layer.cornerRadius = 6;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.image = [UIImage imageNamed:@"Mic01"];
        [self addSubview:self.imageView];
        
        UIImageView *imgCover = [[UIImageView alloc] init];
        imgCover.image = [UIImage imageNamed:@"17-Play-256"];
        [self addSubview:imgCover];
        [imgCover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.imageView.mas_centerX);
            make.centerY.mas_equalTo(self.imageView.mas_centerY);
        }];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightFrame/8, (WidthFrame-40-40)/3, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = @"《写作技巧》";
        [self addSubview:self.titleLabel];
    }
    return self;
}

@end
