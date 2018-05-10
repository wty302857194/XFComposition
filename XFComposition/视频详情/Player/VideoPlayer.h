//
//  VideoPlayer.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/3.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerConfiguration;

@interface VideoPlayer : UIView

/**
 初始化播放器
 */
- (instancetype)initWithFrame:(CGRect)frame;
/**
 
 @param configuration 播放器配置信息
 */
- (void)setPlayerConfiguration:(PlayerConfiguration *)configuration;

/** 播放视频 */
- (void)_playVideo;
/** 暂停播放 */
- (void)_pauseVideo;
/** 释放播放器 */
- (void)_deallocPlayer;

@end
