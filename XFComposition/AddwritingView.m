//
//  AddwritingView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "AddwritingView.h"

@implementation AddwritingView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        //        self.alpha = 0.01f;
        UIView *backView = [[UIView alloc]init];
        backView.bounds = CGRectMake(0, 0, WidthFrame - 80, 260);
        backView.center = CGPointMake(self.width/2, self.height/2);
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        UIButton *backbt = [[UIButton alloc]initWithFrame:CGRectMake(backView.width-50, 5, 40, 20)];
        backbt.titleLabel.font = [UIFont systemFontOfSize:8];
        [backbt setTitle:@"返回" forState:UIControlStateNormal];
        [backbt setBackgroundColor:[UIColor blueColor]];
        [backbt addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:backbt];
        
        
        self.titletextfield =  [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backbt.frame), backView.width, 30)];
        self.titletextfield.font = [UIFont systemFontOfSize:15];

        self.titletextfield.placeholder = @"请输入标题";
        //设置占位符居中
        UILabel * placeholderLabel = [self.titletextfield valueForKey:@"_placeholderLabel"];
        placeholderLabel.textAlignment = NSTextAlignmentCenter;
        
        self.titletextfield.layer.borderWidth = 0.5;
        self.titletextfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.titletextfield.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:self.titletextfield];
        
        
        self.textview = [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titletextfield.frame), backView.width, 120)];
        self.textview.layer.borderWidth = 0.5;
        self.textview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
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
    if ([self.delegate respondsToSelector:@selector(newWriting)]) {
        [self.delegate newWriting];
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

- (void)setPlaceHolder{
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([UITextView class], &count);
    
    for (int i = 0; i < count; i++) {
        
        Ivar ivar = ivars[i];
        
        const char *name = ivar_getName(ivar);
        
        NSString *objcName = [NSString stringWithUTF8String:name];
        
        if ([objcName isEqualToString:@"_placeholderLabel"]) {
            
            UILabel *placeHolderLabel = [[UILabel alloc] init];
            
            placeHolderLabel.text = @"请输入内容";
            
            placeHolderLabel.numberOfLines = 0;
            
            placeHolderLabel.textColor = [UIColor lightGrayColor];
            
            [placeHolderLabel sizeToFit];
            
            [self.textview addSubview:placeHolderLabel];
            
            placeHolderLabel.font = self.textview.font;
            
            [self.textview setValue:placeHolderLabel forKey:@"_placeholderLabel"];
            
            break;
            
        }
        
    }
    free(ivars);
}

@end



