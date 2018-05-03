//
//  ShowtextView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/15.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ShowtextView.h"
@interface ShowtextView ()<UITextViewDelegate>
@end
@implementation ShowtextView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
//        self.backgroundColor = [UIColor clearColor];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, WidthFrame, 260)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];

        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 30)];
        label1.text = @"习作浏览";
        label1.font = [UIFont systemFontOfSize:12];
        [backView addSubview:label1];
        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(WidthFrame-50, 10, 40, 20)];
        bt.titleLabel.font = [UIFont systemFontOfSize:10];
        [bt setTitle:@"返回" forState:UIControlStateNormal];
        [bt setBackgroundColor:[UIColor blueColor]];
        [bt addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:bt];
        
        
        self.titletextfield = [[UITextField alloc]initWithFrame:CGRectMake(0, 40, WidthFrame, 30)];
        self.titletextfield.textAlignment = NSTextAlignmentCenter;
        self.titletextfield.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [backView addSubview:self.titletextfield];
        
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 70, WidthFrame, 110)];
        self.textView.backgroundColor = [UIColor lightGrayColor];
        [backView addSubview:self.textView];
        
        self.timeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.textView.frame)+10, 40, 20)];
        self.timeLabel1.text = @"时间 :";
        self.timeLabel1.font = [UIFont systemFontOfSize:10];
        [backView addSubview:self.timeLabel1];
        
        self.timeLabel2  = [[UILabel alloc]initWithFrame:CGRectMake(47, CGRectGetMaxY(self.textView.frame)+10, 200, 20)];
        self.timeLabel2.font = [UIFont systemFontOfSize:10];
        self.timeLabel2.text = @"2017/2/2/3";
        [backView addSubview:self.timeLabel2];
        
        self.baocunBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.baocunBt setTitle:@"保存" forState:UIControlStateNormal];
        self.baocunBt.frame = CGRectMake(5, CGRectGetMaxY(self.timeLabel1.frame)+10, 30, 30);
        self.baocunBt.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.baocunBt setBackgroundColor:UIColorFromRGBA(64, 224, 208, 1.0f)];
        [self.baocunBt addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
        self.baocunBt.layer.cornerRadius =4;
        self.baocunBt.layer.masksToBounds = YES;
        [backView addSubview:self.baocunBt];

        
    }
    return self;
}

-(void)baocun{
    if ([self.delegate respondsToSelector:@selector(hold :)]) {
        [self.delegate hold :self.typeId];
    }
    
}
-(void)textViewDidChange:(UITextView *)textView{
    static CGFloat maxHeight =120.0f;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height<=frame.size.height) {
        size.height=frame.size.height;
    }else{
        if (size.height >= maxHeight)
        {
            size.height = maxHeight;
            textView.scrollEnabled = YES;   // 允许滚动
        }
        else
        {
            textView.scrollEnabled = NO;    // 不允许滚动
        }
    }
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return false;
    }
    return true;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
