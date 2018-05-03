
//
//  ConmHeadView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ConmHeadView.h"

@implementation ConmHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _tabBtnArray = [[NSMutableArray alloc]init];
        NSArray *array = @[@"全部习作",@"微课习作",@"活动习作",@"独立习作"];
        
        CGFloat btW = (WidthFrame-80-20*3)/4;
        for (int i = 0; i<4; i++) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [bt setTitle:array[i] forState:UIControlStateNormal];
            bt.tag = 1000+i;
            bt.titleLabel.font = [UIFont systemFontOfSize:12];
            bt.layer.cornerRadius = 6;
            bt.clipsToBounds = YES;
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            bt.frame = CGRectMake(40+(btW+20)*i, 3, btW, 24);
            bt.backgroundColor = UIColorFromRGBA(30, 144, 255, 1.0f);
            bt.titleLabel.adjustsFontSizeToFitWidth = YES;
            //            [bt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            //            [bt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
            //            bt.sd_layout.leftSpaceToView(self, 40).topSpaceToView(self, 3).heightIs(34);
            [_tabBtnArray addObject:bt];
            if (i == 0) {
                [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            [self addSubview:bt];
            
        }
    }
    return  self;
}
-(void)click:(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(srollView:)]) {
        [self.delegate srollView:bt];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
