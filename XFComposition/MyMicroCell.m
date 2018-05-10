//
//  MyMicroCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MyMicroCell.h"

@implementation MyMicroCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = hexColor(888888).CGColor;
        self.layer.borderWidth = 0.5;
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/3-30, 80)];
        [self.contentView addSubview:self.imageView];
        
        UIImageView *imgCover = [[UIImageView alloc] init];
        imgCover.image = [UIImage imageNamed:@"17-Play-256"];
        [self.contentView addSubview:imgCover];
        [imgCover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.imageView.mas_centerX);
            make.centerY.mas_equalTo(self.imageView.mas_centerY);
        }];
        
        self.titleLable = [[UILabel alloc]init];
        self.titleLable.text = @"科技厉害";
        self.titleLable.numberOfLines = 3;
        self.titleLable.font = [UIFont systemFontOfSize:12];
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLable];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_bottom);
            make.left.mas_equalTo(self.imageView.mas_left);
            make.right.mas_equalTo(self.imageView.mas_right);
        }];
        
        
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bt setBackgroundImage:[UIImage imageNamed:@"aixin_s"] forState:UIControlStateNormal];
        [self.bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.bt];
        [self.bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_top).offset(10);
            make.right.mas_equalTo(self.imageView.mas_right).offset(-10);
            make.width.mas_equalTo(25);
            make.height.equalTo(self.bt.mas_width);
        }];
    }
    return self;
}
-(void)click :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(CancelCollect :)]) {
        [self.delegate CancelCollect:bt];
    }

}
@end
