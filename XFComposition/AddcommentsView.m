//
//  AddcommentsView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "AddcommentsView.h"

@implementation AddcommentsView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
//        self.alpha = 0.01f;
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, WidthFrame, 260)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        UIButton *backbt = [[UIButton alloc]initWithFrame:CGRectMake(WidthFrame-50, 5, 40, 20)];
        backbt.titleLabel.font = [UIFont systemFontOfSize:8];
        [backbt setTitle:@"返回" forState:UIControlStateNormal];
        [backbt setBackgroundColor:[UIColor blueColor]];
        [backbt addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:backbt];
        self.titletextfield =  [[UITextField alloc]initWithFrame:CGRectMake(20, 30, WidthFrame-70, 30)];
        self.titletextfield.placeholder = @"标题";
        self.titletextfield.layer.cornerRadius =4;
        self.titletextfield.layer.masksToBounds = YES;
        self.titletextfield.layer.borderWidth = 0.5;
        self.titletextfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.titletextfield.clearButtonMode=UITextFieldViewModeWhileEditing;
        self.titletextfield.backgroundColor = [UIColor lightGrayColor];
        [backView addSubview:self.titletextfield];
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setTitle:@"保存" forState:UIControlStateNormal];
        bt.frame = CGRectMake(WidthFrame-48, 30, 30, 30);
        bt.titleLabel.font = [UIFont systemFontOfSize:10];
        [bt setBackgroundColor:UIColorFromRGBA(64, 224, 208, 1.0f)];
        bt.layer.cornerRadius =4;
        bt.layer.masksToBounds = YES;
        [backView addSubview:bt];
        
        self.textview = [[UITextView alloc]initWithFrame:CGRectMake(20, 80, WidthFrame-40, 120)];
//        self.textview.layer.masksToBounds = YES;
        self.textview.layer.borderWidth = 0.5;
        self.textview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.textview.backgroundColor = [UIColor lightGrayColor];
        [backView addSubview:self.textview];
        
        UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt2 setTitle:@"保存" forState:UIControlStateNormal];
        bt2.frame = CGRectMake(20, CGRectGetMaxY(self.textview.frame)+10, 30, 30);
        bt2.titleLabel.font = [UIFont systemFontOfSize:10];
        [bt2 setBackgroundColor:UIColorFromRGBA(64, 224, 208, 1.0f)];
        [bt2 addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
        bt2.layer.cornerRadius =4;
        bt2.layer.masksToBounds = YES;
        [backView addSubview:bt2];
    }
    return self;
}
-(void)baocun{
    if ([self.delegate respondsToSelector:@selector(preservestage)]) {
        [self.delegate preservestage];
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
-(void)dismissView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0;
    }];
//    [self removeFromSuperview];
}



@end
