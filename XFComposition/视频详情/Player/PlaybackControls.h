//
//  PlaybackControls.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/3.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoSlider.h"
#import "PlayerConfiguration.h"

/** 播放器控制面板代理 */
@protocol PlaybackControlsDelegate <NSObject>

@required
/**
 播放按钮点击事件
 @param selected 按钮选中状态
 */
- (void)playButtonAction:(BOOL)selected;
/** 全屏切换按钮点击事件 */
- (void)fullScreenButtonAction;
- (void)retryButtonAction;

/** 滑杆开始拖动 */
- (void)videoSliderTouchBegan:(VideoSlider *)slider;
/** 滑杆拖动中 */
- (void)videoSliderValueChanged:(VideoSlider *)slider;
/** 滑杆结束拖动 */
- (void)videoSliderTouchEnded:(VideoSlider *)slider;

@optional
/** 控制面板单击事件 */
- (void)tapGesture;
/** 控制面板双击事件 */
- (void)doubleTapGesture;

@end

@interface PlaybackControls : UIView
/** 底部控制栏 */
@property (nonatomic, strong)UIView *bottomControlsBar;
/** 顶部控制栏 */
@property (nonatomic, strong)UIView *topControlsBar;
/** 顶部返回按钮 */
@property (nonatomic, strong)UIButton *backButton;
/** 顶部标题 */
@property (nonatomic, strong)UILabel *titleLab;
/** 播放按钮 */
@property (nonatomic, strong) UIButton *playButton;
/** 全屏切换按钮 */
@property (nonatomic, strong) UIButton *fullScreenButton;
/** 进度滑杆 */
@property (nonatomic, strong) VideoSlider *videoSlider;
/** 播放时间 */
@property (nonatomic, strong) UILabel *playTimeLabel;
/** 视频总时间 */
@property (nonatomic, strong) UILabel *totalTimeLabel;
/** 进度条 */
@property (nonatomic, strong) UIProgressView *progress;
/** 播放器控制面板代理 */
@property (nonatomic, weak) id<PlaybackControlsDelegate> delegate;
/** 隐藏控制面板延时时间 缺省5s */
@property (nonatomic, assign) NSTimeInterval hideInterval;
/** 是否处于全屏状态 */
@property (nonatomic, assign) BOOL isFullScreen;
/** 加载指示器 */
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
/** 加载失败重试按钮 */
@property (nonatomic, strong) UIButton *retryButton;

/**
 设置视频时间显示以及滑杆状态
 @param playTime 当前播放时间
 @param totalTime 视频总时间
 @param sliderValue 滑杆滑动值
 */
- (void)_setPlaybackControlsWithPlayTime:(NSInteger)playTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)sliderValue;

/** progress显示缓冲进度 */
- (void)_setPlayerProgress:(CGFloat)progress;
/** 显示或隐藏控制面板 */
- (void)_playerShowOrHidePlaybackControls;
/** 显示或隐藏状态栏 */
- (void)_showOrHideStatusBar;
/** 取消延时隐藏playbackControls */
- (void)_playerCancelAutoHidePlaybackControls;
/** 延时自动隐藏控制面板 */
- (void)_playerAutoHidePlaybackControls;
/** 显示或隐藏加载指示器 */
- (void)_activityIndicatorViewShow:(BOOL)show;
/** 控制播放按钮选择状态 */
- (void)_setPlayButtonSelect:(BOOL)select;
/** 显示或隐藏重新加载按钮 */
- (void)_retryButtonShow:(BOOL)show;

@end
