//
//  toolbarView.m
//  HuiToch
//
//  Created by 周凤喜 on 2017/8/19.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "toolbarView.h"
@interface toolbarView ()

@end
@implementation toolbarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSomeview];
    }

    return self;
}
-(void)addSomeview{
    NSArray *arry = @[@"点击1",@"点击2",@"点击3",@"点击4",@"评论",@"点击6"];
    int z = 1000;
    int g = 0;
    for (int i = 0; i<2; i++) {
        for (int j=0; j<3; j++) {
            z++;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0+self.frame.size.width/3*j, 20+(self.frame.size.height-20)/2*i, self.frame.size.width/3, (self.frame.size.height-20)/2);
            button.tag = z;
            [button setTitle:arry[g] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(didsome:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            g++;
        }
    }
    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-20, 0, 20, 20)];
    [bt addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    [bt setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
    [self addSubview:bt];
}
-(void)didsome:(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(doSomething:)]) {
        [self.delegate doSomething:bt];
    }
    [self disMiss];
}
-(void)showView{
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];

}

-(void)disMiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0;
    }];

}
@end
