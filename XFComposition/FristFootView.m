//
//  FristFootView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/18.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "FristFootView.h"

@implementation FristFootView
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.moreButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.moreButton  addTarget:self action:@selector(getMore:) forControlEvents:UIControlEventTouchUpInside];
        [self.moreButton  setTitle:@"更多" forState:UIControlStateNormal];
//        self.moreButton .tag = 1000+i;
        self.moreButton .titleLabel.font = [UIFont systemFontOfSize:12];
        self.moreButton .layer.cornerRadius = 6;
        self.moreButton .clipsToBounds = YES;
        [self.moreButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.moreButton .frame =CGRectMake(WidthFrame/2-20, 10, 40, 20);
        self.moreButton .backgroundColor = UIColorFromRGBA(30, 144, 255, 1.0f);
        self.moreButton .titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.moreButton];
        
    }
    return self;
}
-(void)getMore:(UIButton *)bt{
    
    if ([self.delegate respondsToSelector:@selector(getMoreWithdifference)]) {
        [self.delegate getMoreWithdifference];
    }
}
@end
