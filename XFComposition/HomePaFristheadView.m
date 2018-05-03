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
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 1)];
        label.backgroundColor = UIColorFromRGBA(220, 220, 220, 1.0f);
        [self addSubview:label];
        
        UILabel *leftLable = [[UILabel alloc]init];
        leftLable.frame = CGRectMake(20, 5, 2, 16);
        leftLable.backgroundColor = [UIColor colorWithHexString:@"3893CF"];
        [self addSubview:leftLable];
        self.textLable = [[UILabel alloc]init];
        [self addSubview:self.textLable];
        self.textLable.sd_layout.leftSpaceToView(leftLable, 20).topSpaceToView(self, 5).heightIs(16);
        [self.textLable setSingleLineAutoResizeWithMaxWidth:0];

        [self.textLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
        
        
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bt setTitle:@" 更多推荐 " forState:UIControlStateNormal];
        self.bt.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.bt setBackgroundColor:[UIColor colorWithHexString:@"3893CF"]];
        self.bt.frame = CGRectMake(WidthFrame -60 -20, 7, 60, 20);
        [self.bt addTarget:self action:@selector(doMore) forControlEvents:UIControlEventTouchUpInside];
        self.bt.layer.cornerRadius = 10;
        self.bt.clipsToBounds=YES;
        [self addSubview:self.bt];
        
    }
    return self;
}
-(void)doMore{
    
    if ([self.delegate respondsToSelector:@selector(getMore :)]) {
        [self.delegate getMore:self.bt];
    }
    
}

@end
