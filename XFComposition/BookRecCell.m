//
//  BookRecCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookRecCell.h"

@implementation BookRecCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-1, 139.5)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, WidthFrame/4-20, 100)];
        [backView addSubview:self.imgView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame/4-5, 0, WidthFrame/4-5, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
//        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textColor = [UIColor colorWithHexString:@"4EA9A4"];
        [backView addSubview:self.titleLabel];
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame/4-5, CGRectGetMaxY(self.titleLabel.frame), WidthFrame/4-5, 20)];
        self.timeLabel.font = [UIFont systemFontOfSize:11];
        [backView addSubview:self.timeLabel];
        
        self.chubanLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame/4-5, CGRectGetMaxY(self.timeLabel.frame), WidthFrame/4-5, 20)];
        self.chubanLabel.font = [UIFont systemFontOfSize:11];
        [backView addSubview:self.chubanLabel];
        
        self.authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame/4-5, CGRectGetMaxY(self.chubanLabel.frame), WidthFrame/4-5, 20)];
        self.authorLabel.font = [UIFont systemFontOfSize:11];
        [backView addSubview:self.authorLabel];
        
        self.gradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame/4-5, CGRectGetMaxY(self.authorLabel.frame), WidthFrame/4-5, 20)];
        self.gradeLabel.font = [UIFont systemFontOfSize:11];
        [backView addSubview:self.gradeLabel];
        
        self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame/4-5, CGRectGetMaxY(self.gradeLabel.frame), WidthFrame/4-5, 20)];
        self.numLabel.font = [UIFont systemFontOfSize:11];
        [backView addSubview:self.numLabel];
        
    }
    return self;
}
@end
