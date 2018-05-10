//
//  MarkSDView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MarkSDView.h"
@interface MarkSDView ()
@property (nonatomic,strong)UIView *backView2;
@property (nonatomic,strong)UITextField *textField6;
@property (nonatomic,strong)UITextField *textField7;
@property (nonatomic,strong)UITextField *textField8;
@property (nonatomic,strong)UITextField *textField9;
@end
@implementation MarkSDView

-(UIView *)backView2{
    if (!_backView2) {
        _backView2 = [[UIView alloc]initWithFrame:CGRectMake(20, HeightFrame/2-140, WidthFrame-40, 280)];
        self.backView2.layer.cornerRadius = 4;
        self.backView2.layer.masksToBounds = YES;
        self.backView2.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.backView2];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, WidthFrame-100, 60)];
        label.text = @"保存试卷";
        label.font = [UIFont systemFontOfSize:18];
        [self.backView2 addSubview:label];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, 80, 35)];
        
        [self makeLabel:label1 :self.backView2 :@"试卷名称"];
        self.textField6 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 80, WidthFrame-80-80, 35)];
        [self maketextfield:self.textField6 :self.backView2];
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label1.frame)+15, 80, 35)];
        [self makeLabel:label2 :self.backView2 :@"试卷时间"];
        self.textField7 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), CGRectGetMaxY(label1.frame)+15, 60, 35)];
        self.textField7.text = @"30";
        
        [self maketextfield:self.textField7 :self.backView2];
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.textField7.frame), CGRectGetMaxY(label1.frame)+15, 100, 35)];
        [self makeLabel:label3 :self.backView2 :@"试卷及格分数"];
        self.textField8 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame), CGRectGetMaxY(label1.frame)+15, 60, 35)];
        self.textField8.text = @"30";
        [self maketextfield:self.textField8 :self.backView2];
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label2.frame)+15, 80, 35)];
        [self makeLabel:label4 :self.backView2 :@"试卷说明"];
        self.textField9 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label4.frame), CGRectGetMaxY(label2.frame)+15, WidthFrame-80-80, 35)];
        
        [self maketextfield:self.textField9:self.backView2];
        UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt2 setBackgroundColor:[UIColor colorWithHexString:@"3B8DBC"]];
        bt2.frame = CGRectMake(20, 235, 40, 30);
        bt2.layer.cornerRadius = 4;
        bt2.layer.masksToBounds = YES;
        [bt2 setTitle:@"保存" forState:UIControlStateNormal];
        bt2.titleLabel.font = [UIFont systemFontOfSize:13];
        [bt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bt2 addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
        [self.backView2 addSubview:bt2];
        
        UIButton *bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt3 setBackgroundColor:[UIColor colorWithHexString:@"EB6752"]];
        bt3.frame = CGRectMake(WidthFrame-40-20-40, 235, 40, 30);
        bt3.layer.cornerRadius = 4;
        bt3.layer.masksToBounds = YES;
        [bt3 setTitle:@"取消" forState:UIControlStateNormal];
        [bt3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bt3 addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        bt3.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.backView2 addSubview:bt3];
        
    }
    return _backView2;
    
}
-(void)makeLabel :(UILabel *)label :(UIView *)view :(NSString *)str{
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithHexString:@"F3F4F3"];
    label.text = str;
    [view addSubview:label];
    
}
-(void)maketextfield :(UITextField *)tetxtfield :(UIView *)view{
    tetxtfield.clearButtonMode=YES;
    tetxtfield.leftViewMode=UITextFieldViewModeAlways;
    //        [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
    tetxtfield.font = [UIFont systemFontOfSize:14];
    tetxtfield.layer.borderWidth = 0.5;
    tetxtfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [view addSubview:tetxtfield];
}

-(void)baocun{
    if ([self.delegate respondsToSelector:@selector(shoudongbaocun:::::)]) {
        [self.delegate shoudongbaocun:self.textField6.text :self.textField9.text :@"0" :self.textField7.text :self.textField8.text];
    }
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        
        [self addSubview:self.backView2];
        
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
-(void)dissMiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0;
    }];
}
@end
