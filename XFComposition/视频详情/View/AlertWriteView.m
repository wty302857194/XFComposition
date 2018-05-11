//
//  AlertWriteView.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "AlertWriteView.h"

@interface AlertWriteView ()

@property (nonatomic, strong) UIView  *contentView;
@property (nonatomic,strong)UITextField *titletextfield;
@property (nonatomic,strong)UITextView *textview;

@end

@implementation AlertWriteView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutAllSubviews];
    }
    return self;
}

- (void)layoutAllSubviews{
    
    /*创建灰色背景*/
    UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
    bgView.alpha = 0.3;
    bgView.backgroundColor = [UIColor blackColor];
    [self addSubview:bgView];
    
    
    /*添加手势事件,移除View*/
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissContactView:)];
    [bgView addGestureRecognizer:tapGesture];
    
    /*创建显示View*/
    _contentView = [[UIView alloc] init];
    _contentView.bounds = CGRectMake(0, 0, self.width - 80, 290);
    _contentView.center = CGPointMake(self.width/2, self.height/2);
    _contentView.backgroundColor=[UIColor whiteColor];
    _contentView.layer.cornerRadius = 4;
    _contentView.layer.masksToBounds = YES;
    [self addSubview:_contentView];
    /*可以继续在其中添加一些View 虾米的*/
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentView.width, 40)];
    topView.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1"];
    [_contentView addSubview:topView];
    
    UILabel *topLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 40)];
    topLab.text = @"添加段落";
    topLab.font = [UIFont systemFontOfSize:15];
    topLab.textColor = [UIColor colorWithHexString:@"#505050"];
    [topView addSubview:topLab];
    
    UIButton *backbt = [[UIButton alloc]initWithFrame:CGRectMake(_contentView.width-50, 0, 40, 40)];
    backbt.titleLabel.font = [UIFont systemFontOfSize:8];
    [backbt setImage:[UIImage imageNamed:@"base_close"] forState:UIControlStateNormal];
    [backbt setTintColor:[UIColor blackColor]];
    [backbt setImageEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    [backbt addTarget:self action:@selector(dismissContactView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backbt];
    
    
    self.titletextfield =  [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), _contentView.width, 30)];
    self.titletextfield.font = [UIFont systemFontOfSize:15];
    
    self.titletextfield.placeholder = @"请输入标题";
    //设置占位符居中
    UILabel * placeholderLabel = [self.titletextfield valueForKey:@"_placeholderLabel"];
    placeholderLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titletextfield.layer.borderWidth = 0.5;
    self.titletextfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.titletextfield.textAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:self.titletextfield];
    
    
    self.textview = [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titletextfield.frame), _contentView.width, 180)];
    self.textview.layer.borderWidth = 0.5;
    self.textview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.textview.font = [UIFont systemFontOfSize:15];
    [self setPlaceHolder];
    [_contentView addSubview:self.textview];
    
    UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt2 setTitle:@"保存" forState:UIControlStateNormal];
    bt2.frame = CGRectMake(_contentView.width- 70, CGRectGetMaxY(self.textview.frame)+10, 50, 20);
    bt2.titleLabel.font = [UIFont systemFontOfSize:10];
    bt2.backgroundColor = [UIColor colorWithHexString:@"#19a1d8"];
    [bt2 addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    bt2.layer.cornerRadius =4;
    bt2.layer.masksToBounds = YES;
    [_contentView addSubview:bt2];
    
}
#pragma mark - 手势点击事件,移除View
- (void)dismissContactView:(UITapGestureRecognizer *)tapGesture{
    
//    [self dismissContactView];
}
- (void)save
{
    
}
-(void)dismissContactView
{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    
}

// 这里加载在了window上
-(void)showView
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
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
