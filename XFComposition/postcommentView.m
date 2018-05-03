//
//  postcommentView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "postcommentView.h"

@implementation postcommentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(20, 100, WidthFrame-40, 200)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        UIButton *backbt = [[UIButton alloc]initWithFrame:CGRectMake(WidthFrame-100, 5, 40, 20)];
        backbt.titleLabel.font = [UIFont systemFontOfSize:10];
        [backbt setTitle:@"返回" forState:UIControlStateNormal];
        [backbt setBackgroundColor:[UIColor colorWithHexString:@"4EBBEE"]];
        backbt.layer.cornerRadius = 4;
        backbt.layer.masksToBounds = YES;
        [backbt addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:backbt];
        
        self.textview = [[UITextView alloc]initWithFrame:CGRectMake(20, 30, WidthFrame-80, 100)];
        
        
        [backView addSubview:self.textview];
        self.textview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.textview.layer.borderWidth = 1;
        self.textview.layer.cornerRadius = 4;
        self.textview.layer.masksToBounds = YES;
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setTitle:@"发布评论" forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bt.layer.cornerRadius = 4;
        bt.layer.masksToBounds = YES;
        bt.backgroundColor = [UIColor colorWithHexString:@"4EBBEE"];
        bt.frame = CGRectMake(WidthFrame-140, CGRectGetMaxY(self.textview.frame)+5, 80, 30);
        [bt addTarget:self action:@selector(clickfabu :) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:bt];
    }
    return self;
}
-(void)clickfabu :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(clickfb :)]) {
        [self.delegate clickfb:bt];
    }
    
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
-(void)dissMiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0;
    }];
}
@end
