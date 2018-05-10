//
//  PlayerConfiguration.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/3.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 视频拉伸方式 */
typedef NS_ENUM(NSUInteger, VideoGravity){
    VideoGravityResize,       //非均匀拉伸。两个维度完全填充至整个视图区域
    VideoGravityResizeAspect,     //等比例拉伸，直到一个维度到达区域边界
    VideoGravityResizeAspectFill, //等比例拉伸，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
};


@interface PlayerConfiguration : NSObject

/** 视频数据源 */
@property (nonatomic, strong) NSURL *sourceUrl;
/** 视频占位图片 */
@property (nonatomic, assign) NSString *imageUrl;
/** 是否自动播放 */
@property (nonatomic, assign) BOOL shouldAutoPlay;
/** 视频拉伸方式 */
@property (nonatomic, assign) VideoGravity videoGravity;
/** 是否重复播放 */
@property (nonatomic, assign) BOOL repeatPlay;
/** 是否支持双击暂停或播放 */
@property (nonatomic, assign) BOOL supportedDoubleTap;
/** 是否支持自动转屏 */
@property (nonatomic, assign) BOOL shouldAutorotate;



@end
