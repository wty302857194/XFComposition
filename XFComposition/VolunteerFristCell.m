//
//  VolunteerFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "VolunteerFristCell.h"
#import "JGInfiniteScrollView.h"
@interface VolunteerFristCell () <JGInfiniteScrollViewDelegate>

@end
@implementation VolunteerFristCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame/3-44)];
//
//        imgView.image = [UIImage imageNamed:@"banner_zhiyuanzhe"];
//        [self addSubview:imgView];
        
        JGInfiniteScrollView *scrollView = [[JGInfiniteScrollView alloc] init];
        scrollView.frame = CGRectMake(0, 0, WidthFrame, HeightFrame/3-44);
        scrollView.images = @[
                              [UIImage imageNamed:@"baner"],
                              [UIImage imageNamed:@"banner_weiketang"],
                              [UIImage imageNamed:@"banner_yuedu"],
                              ];
        scrollView.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        scrollView.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        scrollView.delegate = self;
        [self addSubview:scrollView];
        
    }
    return  self;
}
- (void)ScrollViewDidClickAtAnyImageView:(UIImageView *)imageView
{
    
}
@end
