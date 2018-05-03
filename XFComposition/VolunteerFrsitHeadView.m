//
//  VolunteerFrsitHeadView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "VolunteerFrsitHeadView.h"

@implementation VolunteerFrsitHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _tabBtnArray = [[NSMutableArray alloc]init];
        NSArray *array = @[@"志愿教师招募",@"新闻公告"];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthFrame, 40)];
        backView.backgroundColor = hexColor(f4f5f6);
        [self addSubview:backView];
        
        CGFloat btW = (WidthFrame-40)/2.f;
        for (int i = 0; i<array.count; i++) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [bt setTitle:array[i] forState:UIControlStateNormal];
            bt.backgroundColor = [UIColor whiteColor];
            bt.tag = 1000+i;
            bt.titleLabel.font = [UIFont systemFontOfSize:15];
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            bt.frame = CGRectMake(20+btW*i, 0, btW, 40);
            bt.titleLabel.adjustsFontSizeToFitWidth = YES;
            [_tabBtnArray addObject:bt];
            if (i == 0) {
                [bt setTitleColor: UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
            }
            [backView addSubview:bt];
        }
        
        self.sliderV = [[UIView alloc]initWithFrame:CGRectMake(20, 39, btW, 1)];
        self.sliderV.backgroundColor = UIColorFromRGBA(30, 144, 255, 1.0f);
        [backView addSubview:self.sliderV];
    }
    return self;
}
-(void)click:(UIButton *)bt{
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderV.center = CGPointMake(bt.center.x, self.sliderV.center.y);
    }];
    if ([self.delegate respondsToSelector:@selector(VolunteerSrollView:)]) {
        [self.delegate VolunteerSrollView:bt];
    }
}

@end
