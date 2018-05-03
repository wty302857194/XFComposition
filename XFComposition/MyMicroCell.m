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
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/3-30, 80)];
        [self.contentView addSubview:self.imageView];
        
        self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame), WidthFrame/3-30, 20)];
        self.titleLable.text = @"科技厉害";
        self.titleLable.backgroundColor = [UIColor colorWithHexString:@"FCFCDC"];
        self.titleLable.font = [UIFont systemFontOfSize:12];
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLable];
        
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bt setTitle:@"取消收藏" forState:UIControlStateNormal];
        self.bt.frame = CGRectMake(0, CGRectGetMaxY(self.titleLable.frame), WidthFrame/3-30, 30);
        self.bt.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.bt setBackgroundColor:[UIColor colorWithHexString:@"3791CD"]];
        [self.bt addTarget:self action:@selector(click :) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.bt];
        
    }
    return self;
}
-(void)click :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(CancelCollect :)]) {
        [self.delegate CancelCollect:bt];
    }

}
@end
