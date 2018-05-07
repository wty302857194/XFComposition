//
//  HomePaFristheadView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePaFristheadView.h"

@implementation HomePaFristheadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 5)];
        label.backgroundColor = hexColor(e9f4fc);
        [self addSubview:label];
        
        UILabel *leftLable = [[UILabel alloc]init];
        leftLable.frame = CGRectMake(20, (self.height-15-5)/2.f+5, 5, 15);
        leftLable.backgroundColor = [UIColor colorWithHexString:@"3893CF"];
        [self addSubview:leftLable];
        
        self.textLable = [[UILabel alloc]init];
        [self.textLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
        [self addSubview:self.textLable];
//        self.textLable.sd_layout.leftSpaceToView(leftLable, 20).topSpaceToView(self, 5).heightIs(16);
        [self.textLable setSingleLineAutoResizeWithMaxWidth:0];
        [self.textLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(leftLable.mas_centerY);
            make.left.mas_equalTo(leftLable.mas_right).offset(10);
        }];
        
        
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bt setTitle:@" 更多推荐 " forState:UIControlStateNormal];
        self.bt.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.bt setBackgroundColor:[UIColor colorWithHexString:@"3893CF"]];
//        self.bt.frame = CGRectMake(WidthFrame -60 -20, 7, 60, 20);
        [self.bt addTarget:self action:@selector(doMore) forControlEvents:UIControlEventTouchUpInside];
        self.bt.layer.cornerRadius = 10;
        self.bt.clipsToBounds=YES;
        [self addSubview:self.bt];
        [self.bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(leftLable.mas_centerY);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}
-(void)doMore{
    
    if ([self.delegate respondsToSelector:@selector(getMore :)]) {
        [self.delegate getMore:self.bt];
    }
    
}

@end
