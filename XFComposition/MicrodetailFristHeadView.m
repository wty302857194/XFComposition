//
//  MicrodetailFristHeadView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicrodetailFristHeadView.h"

@implementation MicrodetailFristHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, WidthFrame, 39)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        _tabBtnArray = [[NSMutableArray alloc]init];
        NSArray *array = @[@"课程大纲",@"写片段",@"写作文",@"课程交流",@"本课习作",@"公益点评"];
        
        CGFloat btW = (WidthFrame-40-20*5)/6;
        for (int i = 0; i<array.count; i++) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [bt setTitle:array[i] forState:UIControlStateNormal];
            bt.tag = 1000+i;
            bt.titleLabel.font = [UIFont systemFontOfSize:12];
            bt.layer.cornerRadius = 6;
            bt.clipsToBounds = YES;
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            bt.frame = CGRectMake(20+(btW+20)*i, 10, btW, 24);
            bt.backgroundColor = UIColorFromRGBA(30, 144, 255, 1.0f);
            bt.titleLabel.adjustsFontSizeToFitWidth = YES;
            [_tabBtnArray addObject:bt];
            if (i == 0) {
                [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            [backView addSubview:bt];
            
        }
        
    }

    return self;
}
-(void)click:(UIButton *)bt{
    
    if ([self.delegate respondsToSelector:@selector(srollView:)]) {
        [self.delegate srollView:bt];
    }
}

@end
