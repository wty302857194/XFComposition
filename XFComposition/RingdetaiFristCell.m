//
//  RingdetaiFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RingdetaiFristCell.h"

@implementation RingdetaiFristCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
        
        self.imgView.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:self.imgView];
        
        self.titleLable = [[UILabel alloc]init];
        self.numLabel = [[UILabel alloc]init];
        [self sd_addSubviews:@[self.titleLable,self.numLabel]];
        
        
        self.titleLable.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self, 10).heightIs(30);
        [self.titleLable setSingleLineAutoResizeWithMaxWidth:0];
        [self.titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        
        self.numLabel.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.titleLable, 10).heightIs(15);
        [self.numLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.numLabel.font = [UIFont systemFontOfSize:11];
        
        self.memberbt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.memberbt setTitle:@"圈子成员" forState:UIControlStateNormal];
        self.memberbt.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.memberbt setBackgroundColor:[UIColor colorWithHexString:@"4EBBEE"]];
        self.memberbt.layer.cornerRadius = 4;
        self.memberbt.layer.masksToBounds = YES;
        self.memberbt.frame = CGRectMake(WidthFrame-160, 70, 60, 25);
        [self.memberbt addTarget:self action:@selector(showchengyuan) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.memberbt];
        
        
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bt setTitle:@"加入圈子" forState:UIControlStateNormal];
        self.bt.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.bt setBackgroundColor:[UIColor colorWithHexString:@"4EBBEE"]];
        self.bt.layer.cornerRadius = 4;
        self.bt.layer.masksToBounds = YES;
        self.bt.frame = CGRectMake(WidthFrame-90, 70, 60, 25);
        [self.bt addTarget:self action:@selector(click :) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.bt];
    }
    return self;
}
-(void)showchengyuan{
    if ([self.delegate respondsToSelector:@selector(showmember)]) {
        [self.delegate showmember];
    }
    
}
-(void)click :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(joinRing :)]) {
        [self.delegate joinRing :bt];
    }
}
@end
