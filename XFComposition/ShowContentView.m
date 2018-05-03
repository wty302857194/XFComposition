//
//  ShowContentView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/9.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ShowContentView.h"

@implementation ShowContentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, WidthFrame, 400)];
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
        self.titletextfield.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:self.titletextfield];
        
        
        self.textview = [[UITextView alloc]initWithFrame:CGRectMake(20, 80, WidthFrame-40, 260)];
        //        self.textview.layer.masksToBounds = YES;
        self.textview.layer.borderWidth = 0.5;
        self.textview.backgroundColor = [UIColor lightGrayColor];
        self.textview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.textview.backgroundColor = [UIColor lightGrayColor];
        [backView addSubview:self.textview];
        
    }
    return self;
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
