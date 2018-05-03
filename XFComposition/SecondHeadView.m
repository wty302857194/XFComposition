//
//  SecondHeadView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/30.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "SecondHeadView.h"

@implementation SecondHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 1)];
        topLabel.backgroundColor = UIColorFromRGBA(220, 220, 220, 1.0f);
        [self addSubview:topLabel];
        
        UILabel * xianLabel = [[UILabel alloc]initWithFrame:CGRectMake( WidthFrame/6, 20, WidthFrame/6, 0.5)];
        xianLabel.backgroundColor = UIColorFromRGBA(30, 144, 255, 1.0f);
        [self addSubview:xianLabel];
        
        UILabel *xianLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame/3*2, 20, WidthFrame/6, 0.5)];
        xianLabel2.backgroundColor = UIColorFromRGBA(30, 144, 255, 1.0f);
        [self addSubview:xianLabel2];
        
        self.Titlebt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.Titlebt.frame =CGRectMake(WidthFrame/12*5, 5, WidthFrame/6, 30);
        [self.Titlebt setBackgroundImage:[UIImage imageNamed:@"title_bg"] forState:UIControlStateNormal];
        [self.Titlebt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        self.Titlebt.titleLabel.font = [UIFont systemFontOfSize:9];
        [self addSubview: self.Titlebt];
        
        self.moreBt = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.moreBt setTitle:@"更多" forState:UIControlStateNormal];
        self.moreBt.backgroundColor = UIColorFromRGBA(106, 154, 255, 1.0f);
        self.moreBt.titleLabel.font = [UIFont systemFontOfSize:10];
        self.moreBt.layer.cornerRadius = 9;
        self.moreBt.clipsToBounds = YES;
        [self addSubview:self.moreBt];
        self.moreBt.sd_layout.topSpaceToView(self, 10).rightSpaceToView(self, 10).heightIs(18).widthIs(30);
    }
    return self;
}

@end
