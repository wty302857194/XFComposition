//
//  HomePaSixCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePaSixCell.h"

@implementation HomePaSixCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat imageW = WidthFrame/4-10-10;
        self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, 110)];
//        self.imageView1.backgroundColor = [UIColor yellowColor];
        self.imageView1.image = [UIImage imageNamed:@"icon8_yuwen"];
        [self addSubview:self.imageView1];
        
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame)+5, 0, WidthFrame/4-5, 20)];
        [self.label1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];
        self.label1.textColor = hexColor(323232);
        [self addSubview:self.label1];
        
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame)+10, 22, WidthFrame/4-10, 15)];
        self.label2.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.label2];
        self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame)+10, 39, WidthFrame/4-10, 15)];
        self.label3.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.label3];
        self.label4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame)+10, 56, WidthFrame/4-10, 15)];
        self.label4.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.label4];
        self.label5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame)+10, 73, WidthFrame/4-10, 15)];
        self.label5.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.label5];

    }
    return self;
}

- (void)setModel:(BookModel *)model {
    _model = model;
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:model.BookPic] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
    self.label1.text = [NSString stringWithFormat:@"《%@》",model.BookName];

    self.label2.text = [NSString stringWithFormat:@"推荐时间:%@",[Global dataStringForString:model.BookAddTime]];

    self.label3.text = [NSString stringWithFormat:@"出版社:%@",model.BookPublic];
    self.label4.text = [NSString stringWithFormat:@"作者:%@",model.BookAuthor];
    self.label5.text = [NSString stringWithFormat:@"年级:%@",model.Booktypename];
}
@end
