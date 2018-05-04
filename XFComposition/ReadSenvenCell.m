//
//  ReadSenvenCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadSenvenCell.h"

@implementation ReadSenvenCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, (self.height-10)/2.f, 10, 10)];
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        label.backgroundColor = [UIColor colorWithHexString:@"ABD498"];
        [self.contentView addSubview:label];
        
        self.schoolLabel = [[UILabel alloc]init];
        self.schoolLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.schoolLabel];
        [self.schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        self.textLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, WidthFrame/4-15, 20)];
        self.textLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.textLable];
        [self.textLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label.mas_right).offset(5);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_greaterThanOrEqualTo(self.schoolLabel).offset(10);
        }];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height-1, self.width, 1)];
        imgView.image =[UIImage imageNamed:@"xuxian"];
        [self addSubview:imgView];
        
    }
    
    return self;
}
@end
