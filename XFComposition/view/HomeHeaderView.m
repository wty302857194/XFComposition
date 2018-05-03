//
//  HomeHeaderView.m
//  XFComposition
//
//  Created by wbb on 2018/4/17.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "HomeHeaderView.h"
#import "WaterWaveView.h"
#import "JGInfiniteScrollView.h"

@interface HomeHeaderView ()<JGInfiniteScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *waterWaveView;
@property (weak, nonatomic) IBOutlet UIView *yinDaoView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerLayout;

@end

@implementation HomeHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    WaterWaveView *waveView = [[WaterWaveView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 190)];
    
    
    __weak typeof(self) weakSelf = self;
    waveView.goImagePhotoBlock = ^{
        if (weakSelf.goPhotoBlock) {
            weakSelf.goPhotoBlock();
        }
    };
    [self.waterWaveView addSubview:waveView];

    JGInfiniteScrollView *scrollView = [[JGInfiniteScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, WidthFrame, 100);
    scrollView.images = @[
                          [UIImage imageNamed:@"homTabImgOne"],
                          [UIImage imageNamed:@"homTabImgTwo"],
                          [UIImage imageNamed:@"homTabImgThree"],
                          ];
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    scrollView.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    scrollView.delegate = self;
    [self.yinDaoView addSubview:scrollView];
}
- (IBAction)btnClick:(UIButton *)sender {
    if (self.seeDetailBlock) {
        self.seeDetailBlock(sender.tag);
    }
}
- (void)ScrollViewDidClickAtAnyImageView:(UIImageView *)imageView
{
    
}

@end
