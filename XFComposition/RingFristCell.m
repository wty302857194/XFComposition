//
//  RingFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RingFristCell.h"

@implementation RingFristCell
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame/3)];
        _imageView.image = [UIImage imageNamed:@"banner_quanzi"];

    }
    return _imageView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
//        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.bt.frame = CGRectMake(20, 20, 20, 20);
//        self.bt.backgroundColor = [UIColor clearColor];
//        [self.bt setBackgroundImage:[UIImage imageNamed:@"left-arrow_s"] forState:UIControlStateNormal];
        
        [self addSubview: self.imageView];
//        [self addSubview:self.bt];
        
    }
    return self;
}

@end
