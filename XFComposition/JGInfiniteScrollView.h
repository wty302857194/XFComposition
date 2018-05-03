//
//  JGInfiniteScrollView.h
//  无限轮播-Demo
//
//  Created by 郭军 on 16/7/24.
//  Copyright © 2016年 JUN. All rights reserved.
//

#import <UIKit/UIKit.h>

//给图片添加点击事件时调用改代理方法
@protocol JGInfiniteScrollViewDelegate <NSObject>

@optional
- (void)ScrollViewDidClickAtAnyImageView:(UIImageView *)imageView;

@end

@interface JGInfiniteScrollView : UIView
@property (strong, nonatomic) NSArray *images;
@property (weak, nonatomic, readonly) UIPageControl *pageControl;
@property (assign, nonatomic, getter=isScrollDirectionPortrait) BOOL scrollDirectionPortrait;

//代理
@property (nonatomic, weak) id<JGInfiniteScrollViewDelegate> delegate;

@end
