//
//  WelecomeView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "WelecomeView.h"
@interface WelecomeView()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;//欢迎滚动图
@property (nonatomic,strong)UIPageControl *pageView;//指示器
@property (nonatomic,strong)NSArray *imageNameArray;//滚动图片
@end

@implementation WelecomeView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageView];
    }
    return self;
}
-(NSArray *)imageNameArray{
    if (!_imageNameArray) {
        _imageNameArray = @[@"pic_qidongye01",@"pic_qidongye02",@"pic_qidongye03"];
    }
    return _imageNameArray;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        for (int i = 0; i<self.imageNameArray.count; i++) {
            UIImage *image = [UIImage imageNamed:self.imageNameArray[i]];
            UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
            imageView.backgroundColor = [UIColor redColor];
            imageView.frame = CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height);
            [_scrollView addSubview:imageView];
        }
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize =CGSizeMake(self.frame.size.width*self.imageNameArray.count, self.frame.size.height);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(self.frame.size.width *2+self.frame.size.width/3-15, self.frame.size.height/4*3+30, self.frame.size.width/3+35, 50);
        [button setTitle:@"立即体验" forState:UIControlStateNormal];
        button.backgroundColor=[UIColor colorWithRed:176/255.0f green:224/255.0f blue:230/255.0f alpha:1.0f];
        button.layer.cornerRadius=10;
        button.layer.masksToBounds=YES;
        [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }
    return _scrollView;
}
-(UIPageControl *)pageView{
    if (!_pageView) {
        _pageView = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width/2-20, self.frame.size.height-40, 40, 5)];
        _pageView.numberOfPages = self.imageNameArray.count;
        _pageView.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageView.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageView.userInteractionEnabled = YES;
        _pageView.currentPage = 0;
        [_pageView addTarget:self action:@selector(showDamine:) forControlEvents:UIControlEventValueChanged] ;
         
    }
    return _pageView;
}
-(void)showDamine:(UIPageControl *)aPageControl{
    NSInteger whichPage = aPageControl.currentPage;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * whichPage, 0.0f) animated:YES];
    
    [UIView commitAnimations];
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIView * mainScrollView2=[[UIView alloc]initWithFrame:CGRectMake(0, 66, self.frame.size.width, self.frame.size.height/2-90)];
    NSInteger currentPageIndex = scrollView.contentOffset.x / mainScrollView2.frame.size.width;
    self.pageView.currentPage = currentPageIndex;
}
-(void)clickButton{
    if ([self.delegate respondsToSelector:@selector(removeWelecomeView)]) {
        [self.delegate removeWelecomeView];
    }

}

@end
