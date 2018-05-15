//
//  PlaybackControls.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/3.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "PlaybackControls.h"

static const CGFloat PlaybackControlsAutoHideTimeInterval = 0.3f;

@interface PlaybackControls()

/** 控制面板是否显示 */
@property (nonatomic, assign) BOOL isShowing;
/** 加载指示器是否显示 */
@property (nonatomic, assign) BOOL isActivityShowing;
/** 重新加载是否显示 */
@property (nonatomic, assign) BOOL isRetryShowing;

@end

@implementation PlaybackControls

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

/** 创建UI */
- (void)setupUI
{
    self.backgroundColor = [UIColor clearColor];

    [self addSubview:self.topControlsBar];
    [self addSubview:self.bottomControlsBar];
    [self addSubview:self.activityIndicatorView];
    [self addSubview:self.retryButton];
    [self addSubview:self.bgImageView];
    
    [_bgImageView addSubview:self.bgPlayImgView];
    
    [_topControlsBar addSubview:self.backButton];
    [_topControlsBar addSubview:self.titleLab];
    
    [_bottomControlsBar addSubview:self.playButton];
    [_bottomControlsBar addSubview:self.fullScreenButton];
    [_bottomControlsBar addSubview:self.playTimeLabel];
    [_bottomControlsBar addSubview:self.totalTimeLabel];
    [_bottomControlsBar addSubview:self.progress];
    [_bottomControlsBar addSubview:self.videoSlider];
    
    [self makeConstraints];
    [self _resetPlaybackControls];
    [self addGesture];
}

/** 重置控制面板 */
- (void)_resetPlaybackControls
{
    self.bottomControlsBar.alpha = 1;
    self.topControlsBar.alpha =1;
    self.isShowing = YES;
    [self _activityIndicatorViewShow:YES];
    [self performSelector:@selector(_playerHidePlaybackControls) withObject:nil afterDelay:5.0f];
}

/**
 设置视频时间显示以及滑杆状态
 @param playTime 当前播放时间
 @param totalTime 视频总时间
 @param sliderValue 滑杆滑动值
 */
- (void)_setPlaybackControlsWithPlayTime:(NSInteger)playTime totalTime:(NSInteger)totalTime sliderValue:(CGFloat)sliderValue
{
    //当前时长进度progress
    NSInteger proMin = (playTime / 60) % 60;//当前秒
    NSInteger proHou = playTime / 3600 ;//总小时
    NSInteger proSec = playTime % 60;//当前分钟
    //duration 总时长
    NSInteger durMin = (totalTime / 60) % 60;//分钟
    NSInteger durHou = totalTime / 3600 ;//小时
    NSInteger durSec = totalTime % 60;//总秒
    
    //更新当前播放时间
    self.videoSlider.value = sliderValue;
    if (proHou > 0) {
        self.playTimeLabel.text = [NSString stringWithFormat:@"%zd:%02zd:%02zd", proHou, proMin, proSec];
    } else {
        self.playTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", proMin, proSec];

    }
    //更新总时间
    if (durHou > 0) {
        self.totalTimeLabel.text = [NSString stringWithFormat:@"%zd:%02zd:%02zd", durHou, durMin, durSec];
    } else {
        self.totalTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", durMin, durSec];
    }
}

/** 显示或隐藏加载指示器 */
- (void)_activityIndicatorViewShow:(BOOL)show
{
    self.isActivityShowing = show;
    if (show) {
        self.playButton.enabled = NO;
        [self.activityIndicatorView startAnimating];
    }
    else
    {
         self.playButton.enabled = YES;
        if (self.isShowing) {
//            self.playButton.hidden = NO;
           
        }
        [self.activityIndicatorView stopAnimating];
    }
}

/** 显示或隐藏重新加载按钮 */
- (void)_retryButtonShow:(BOOL)show
{
    self.isRetryShowing = show;
    if (show) {
        self.playButton.selected = NO;
//        self.playButton.hidden = YES;
        self.retryButton.hidden = NO;
    }else
    {
        self.retryButton.hidden = YES;
    }
}

/** progress显示缓冲进度 */
- (void)_setPlayerProgress:(CGFloat)progress {
    [self.progress setProgress:progress animated:NO];
}

/** 控制播放按钮选择状态 */
- (void)_setPlayButtonSelect:(BOOL)select
{
    self.playButton.selected = select;
}

/** 显示或隐藏控制面板 */
- (void)_playerShowOrHidePlaybackControls
{
    if (self.isShowing) {
        [self _playerHidePlaybackControls];
    } else {
        [self _playerShowPlaybackControls];
    }
}

/** 显示控制面板 */
- (void)_playerShowPlaybackControls
{
    [self _playerCancelAutoHidePlaybackControls];
    [UIView animateWithDuration:PlaybackControlsAutoHideTimeInterval animations:^{
        [self _showPlaybackControls];
    } completion:^(BOOL finished) {
        self.isShowing = YES;
        [self _playerAutoHidePlaybackControls];
    }];
}

/** 隐藏控制面板 */
- (void)_playerHidePlaybackControls
{
    [self _playerCancelAutoHidePlaybackControls];
    [UIView animateWithDuration:PlaybackControlsAutoHideTimeInterval animations:^{
        [self _hidePlaybackControls];
    } completion:^(BOOL finished) {
        self.isShowing = NO;
    }];
}

/** 显示控制面板 */
- (void)_showPlaybackControls
{
    self.isShowing = YES;
    self.bottomControlsBar.alpha = 1;
    self.topControlsBar.alpha = 1;
    if (!self.isActivityShowing && !self.isRetryShowing) {
        self.playButton.hidden = NO;
    }
    if (self.isFullScreen) {
        [self _showOrHideStatusBar];
    }
    
}

/** 隐藏控制面板 */
- (void)_hidePlaybackControls
{
    self.isShowing = NO;
    self.bottomControlsBar.alpha = 0;
    self.topControlsBar.alpha = 0;
//    self.playButton.hidden = YES;
    if (self.isFullScreen) {
        [self _showOrHideStatusBar];
    }
}

/** 延时自动隐藏控制面板 */
- (void)_playerAutoHidePlaybackControls
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_playerHidePlaybackControls) object:nil];
    [self performSelector:@selector(_playerHidePlaybackControls) withObject:nil afterDelay:5.0f];
}

/** 显示或隐藏状态栏 */
- (void)_showOrHideStatusBar
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

/** 是否处于全屏状态 */
- (void)setIsFullScreen:(BOOL)isFullScreen
{
    _isFullScreen = isFullScreen;
    self.fullScreenButton.selected = _isFullScreen;
    
    [self reMakeConstraints:isFullScreen];
    
}

/** 取消延时隐藏playbackControls */
- (void)_playerCancelAutoHidePlaybackControls
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}


/** 添加手势 */
- (void)addGesture
{
    //单击手势
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:singleTapGesture];
    
    //双击手势
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTapGesture];
    
    //当系统检测不到双击手势时执行再识别单击手势，解决单双击收拾冲突
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
}

// 重制约束
- (void)reMakeConstraints:(BOOL)isFullScreen
{
    if (isFullScreen) {
        _backButton.hidden = NO;
        [_topControlsBar mas_updateConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(self.mas_safeAreaLayoutGuideTop).offset(30);
            } else {
                make.top.equalTo(self).offset(30);
            }
        }];
        
        [_backButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@50);
            make.centerY.equalTo(_topControlsBar);
        }];
        
        [_bottomControlsBar mas_updateConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.right.equalTo(self.mas_safeAreaLayoutGuideRight).offset(-50);
                
            } else {

            }
        }];
    } else {
        _backButton.hidden = YES;
        [_topControlsBar mas_updateConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(self.mas_safeAreaLayoutGuideTop).offset(5);
            } else {
                make.top.equalTo(self).offset(5);
            }
        }];
        
        [_backButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
        
        [_bottomControlsBar mas_updateConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.right.equalTo(self.mas_safeAreaLayoutGuideRight).offset(-15);
            } else {
                
            }
            
        }];
    }
}

/** 添加约束 */
- (void)makeConstraints
{
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(self);
    }];
    
    [_bgPlayImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [_topControlsBar mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.mas_safeAreaLayoutGuideTop).offset(5);
            make.left.equalTo(self.mas_safeAreaLayoutGuideLeft).offset(15);
            make.right.equalTo(self.mas_safeAreaLayoutGuideRight).offset(-15);

        } else {
            make.top.equalTo(self).offset(5);
            make.left.equalTo(@15);
            make.right.equalTo(self).offset(-15);
        }
        make.height.equalTo(@50);
    }];
    
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topControlsBar);
        make.width.equalTo(@0);
        make.height.equalTo(_topControlsBar.mas_height);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backButton.mas_right);
        make.centerY.equalTo(_topControlsBar.mas_centerY);
    }];
    
    [_activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [_retryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [_bottomControlsBar mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.mas_safeAreaLayoutGuideLeft).offset(15);
            make.right.equalTo(self.mas_safeAreaLayoutGuideRight).offset(-15);
            make.bottom.equalTo(self.mas_safeAreaLayoutGuideBottom).offset(-5);
        } else {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-5);
        }
        make.height.equalTo(@50);
    }];
    
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomControlsBar);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerY.equalTo(_bottomControlsBar.mas_centerY);
    }];
    
    [_playTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_playButton.mas_right).offset(5);
        make.width.equalTo(@45);
        make.centerY.equalTo(_bottomControlsBar.mas_centerY);
    }];
    
    [_fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomControlsBar);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerY.equalTo(_bottomControlsBar.mas_centerY);
    }];
    
    [_totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_fullScreenButton.mas_left).offset(-5);
        make.width.equalTo(@45);
        make.centerY.equalTo(_bottomControlsBar.mas_centerY);
    }];
    
    [_progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_playTimeLabel.mas_right).offset(5);
        make.right.equalTo(_totalTimeLabel.mas_left).offset(-5);
        make.height.equalTo(@2);
        make.centerY.equalTo(_bottomControlsBar.mas_centerY);
    }];
    
    [_videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_progress);
    }];
    
    
}

/** 加载指示器 */
- (UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activityIndicatorView;
}

/** 底部控制栏 */
- (UIView *)bottomControlsBar
{
    if (!_bottomControlsBar) {
        _bottomControlsBar = [[UIView alloc]init];
        _bottomControlsBar.userInteractionEnabled = YES;
    }
    return _bottomControlsBar;
}

/** 顶部控制栏 */
- (UIView *)topControlsBar
{
    if (!_topControlsBar) {
        _topControlsBar = [[UIView alloc] init];
    }
    return _topControlsBar;
}

/** 背景图片*/
-(UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toPlay)];
        [_bgImageView addGestureRecognizer:singleTapGesture];
    }
    return _bgImageView;
}
/** 背景上播放图片*/
- (UIImageView *)bgPlayImgView
{
    if (!_bgPlayImgView) {
        _bgPlayImgView = [[UIImageView alloc] init];
        _bgPlayImgView.image = [UIImage imageNamed:@"17-Play-256"];
    }
    return _bgPlayImgView;
}

/** 顶部返回按钮 */
-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"left-arrow_s"] forState:UIControlStateNormal];
        [_backButton setImageEdgeInsets:UIEdgeInsetsMake(14, 0, 14, 28)];
        [_backButton addTarget:self action:@selector(fullScreenAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

/** 顶部标题 */
- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"我的视频";
        _titleLab.textColor = [UIColor whiteColor];
    }
    return _titleLab;
}

/** 播放按钮 */
- (UIButton *)playButton
{
    if (!_playButton){
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"full_play_btn"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"full_pause_btn"] forState:UIControlStateSelected];
        [_playButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

/** 全屏切换按钮 */
- (UIButton *)fullScreenButton
{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:@"mini_launchFullScreen_btn"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage imageNamed:@"mini_launchFullScreen_btn"] forState:UIControlStateSelected];
        [_fullScreenButton addTarget:self action:@selector(fullScreenAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}


/** 当前播放时间 */
- (UILabel *)playTimeLabel
{
    if (!_playTimeLabel) {
        _playTimeLabel = [[UILabel alloc]init];
        _playTimeLabel.font = [UIFont systemFontOfSize:14];
        _playTimeLabel.text = @"00:00";
        _playTimeLabel.adjustsFontSizeToFitWidth = YES;
        _playTimeLabel.textAlignment = NSTextAlignmentCenter;
        _playTimeLabel.textColor = [UIColor whiteColor];
    }
    return _playTimeLabel;
}

/** 视频总时间 */
- (UILabel *)totalTimeLabel
{
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc]init];
        _totalTimeLabel.font = [UIFont systemFontOfSize:14];
        _totalTimeLabel.text = @"00:00";
        _totalTimeLabel.adjustsFontSizeToFitWidth = YES;
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
        _totalTimeLabel.textColor = [UIColor whiteColor];
    }
    return _totalTimeLabel;
}

/** 加载失败重试按钮 */
- (UIButton *)retryButton
{
    if (!_retryButton) {
        _retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _retryButton.backgroundColor = [UIColor colorWithHexString:@"#646464"];
        [_retryButton setTitle:@"点击重试" forState:UIControlStateNormal];
        _retryButton.layer.cornerRadius = 20;
        _retryButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_retryButton addTarget:self action:@selector(retryAction) forControlEvents:UIControlEventTouchUpInside];
        _retryButton.hidden = YES;
    }
    return _retryButton;
}

/** 播放进度条 */
- (UIProgressView *)progress
{
    if (!_progress) {
        _progress = [[UIProgressView alloc]init];
        _progress.progressTintColor = [UIColor whiteColor];
        _progress.trackTintColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    }
    return _progress;
}

/** 滑杆 */
- (VideoSlider *)videoSlider
{
    if (!_videoSlider) {
        _videoSlider = [[VideoSlider alloc]init];
        _videoSlider.minimumTrackTintColor = [UIColor colorWithHexString:@"#d0555f"];
        _videoSlider.maximumTrackTintColor = [UIColor clearColor];
        //开始拖动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        //拖动中事件
        [_videoSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        //结束拖动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
    }
    return _videoSlider;
}

#pragma mark - 滑杆delegate
/** 开始拖动事件 */
- (void)progressSliderTouchBegan:(VideoSlider *)slider{
    if (_delegate && [_delegate respondsToSelector:@selector(videoSliderTouchBegan:)]) {
        [_delegate videoSliderTouchBegan:slider];
    }
}
/** 拖动中事件 */
- (void)progressSliderValueChanged:(VideoSlider *)slider{
    if (_delegate && [_delegate respondsToSelector:@selector(videoSliderValueChanged:)]) {
        [_delegate videoSliderValueChanged:slider];
    }
}
/** 结束拖动事件 */
- (void)progressSliderTouchEnded:(VideoSlider *)slider{
    if (_delegate && [_delegate respondsToSelector:@selector(videoSliderTouchEnded:)]) {
        [_delegate videoSliderTouchEnded:slider];
    }
}

- (void)toPlay
{
    self.bgImageView.hidden = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(playButtonAction:)]) {
        [_delegate playButtonAction:NO];
    }
}
/** 播放按钮点击事件 */
- (void)playAction:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(playButtonAction:)]) {
        [_delegate playButtonAction:button.selected];
    }
}

/** 全屏切换按钮点击事件 */
- (void)fullScreenAction
{

    if (_delegate && [_delegate respondsToSelector:@selector(fullScreenButtonAction)]) {
        [_delegate fullScreenButtonAction];
    }
}

/** 重试按钮点击事件 */
- (void)retryAction
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(retryButtonAction)]) {
        [_delegate retryButtonAction];
    }
}

/** 控制面板单击事件 */
- (void)tap:(UIGestureRecognizer *)gesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(tapGesture)]) {
        [_delegate tapGesture];
    }
}

/** 控制面板双击事件 */
- (void)doubleTap:(UIGestureRecognizer *)gesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(doubleTapGesture)]) {
        [_delegate doubleTapGesture];
    }
}
@end
