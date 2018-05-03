//
//  MicoSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicoSecondCell.h"

@implementation MicoSecondCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        
    }
    return self;
}
-(void)layoutSubviews{

    CGFloat btW = (WidthFrame-20*3)/5*2;
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 5, WidthFrame , 100)];
    scrollView.contentSize = CGSizeMake((btW+20)*self.lableArray.count+20, 80);
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    
    for (int i = 0; i<self.lableArray.count; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        //        [bt setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [bt setBackgroundImage:[UIImage imageNamed:@"XFKe1"] forState:UIControlStateNormal];
        [bt setBackgroundColor:[UIColor lightGrayColor]];
        [bt setTitle:@"" forState:UIControlStateNormal];
        bt.tag = 2000+i;
        bt.layer.cornerRadius = 6;
        bt.layer.masksToBounds = YES;
        bt.frame = CGRectMake(20+btW*i+20*i, 0, btW, 80);
        [scrollView addSubview:bt];
        
        UILabel *dipLabel = [[UILabel alloc]init];
        dipLabel.text = self.lableArray[i];
        dipLabel.font = [UIFont systemFontOfSize:12];
        dipLabel.tag = 1000+i;
        dipLabel.frame = CGRectMake(20+btW*i+20 *i, 80, btW, 20);
        dipLabel.textAlignment = NSTextAlignmentCenter;
        [scrollView addSubview:dipLabel];
    }

    
}
-(void)setClassArray:(NSArray *)classArray{
    _classArray = classArray;
    
}
-(void)setLableArray:(NSArray *)lableArray{
    
    _lableArray = lableArray;
}
-(void)click:(UIButton *)bt{
    NSLog(@"%ld",(long)bt.tag);
    
}

@end
