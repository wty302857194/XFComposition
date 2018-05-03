//
//  HomePaFourCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePaFourCell.h"

@implementation HomePaFourCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgView = [[UIImageView alloc]init];
        self.imgView.frame = CGRectMake(0, 0, (WidthFrame-30-20*2)/3, 70);
        [self.contentView addSubview:self.imgView];
//        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//        [self.bt setBackgroundColor:[UIColor lightGrayColor]];
//        [self.bt setTitle:self.compostitionArray[i] forState:UIControlStateNormal];
        
//        self.bt.frame = CGRectMake(0, 0, (WidthFrame-30-20*2)/3, 70);
//        [self addSubview:self.bt];
    }
    return self;
}


-(void)click:(UIButton *)bt{
//    NSLog(@"%ld",(long)bt.tag);
    
}

@end
