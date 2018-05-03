//
//  RingSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RingSecondCell.h"

@implementation RingSecondCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //        self.titleLabel.sd_layout.leftSpaceToView(self.imageView, 15).topSpaceToView(<#UIView *toView#>, <#CGFloat value#>)
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-20, 60)];
        backView.backgroundColor = UIColorFromRGBA(3, 168, 158, 1.0f);
        backView.layer.cornerRadius=2;
        backView.clipsToBounds =YES;
        [self addSubview:backView];
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
        self.imageView.image = [UIImage imageNamed:@""];
//        self.imageView.backgroundColor = [UIColor redColor];
        [backView addSubview:self.imageView];
        self.backgroundColor = [UIColor yellowColor];
        CGFloat w = WidthFrame/2-20-70;
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, w, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [backView addSubview:self.titleLabel];
        self.userNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 25+2.5, w, 15)];
        self.userNumLabel.font = [UIFont systemFontOfSize:9];
        [backView addSubview:self.userNumLabel];
        self.listLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 45, w, 15)];
        self.listLabel.font = [UIFont systemFontOfSize:9];
        [backView addSubview:self.listLabel];
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 60, WidthFrame/2-20, 40)];
        self.textView.font = [UIFont systemFontOfSize:9];
        self.textView.editable = NO;
        //        self.textView.text = @"圈子简介";
        [self addSubview:self.textView];
        
//        self.userNumLabel.text = [NSString stringWithFormat:@"用户：%@",self.model.JoinNum];
//        self.listLabel.text = [NSString stringWithFormat:@"类别：%@",self.model.TypeName];
//        self.textView.text = [NSString stringWithFormat:@"圈子简介：%@",self.model.GroupInfo];
    }
    return self;
}
@end
