//
//  QYStarReplay.h
//  QYStarDisplay
//
//  Created by qiannian on 2018/5/9.
//  Copyright © 2018年 qiannian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYStarReplay;
typedef void(^finishBlock)(CGFloat currentScore);

typedef NS_ENUM(NSInteger, RateStyle)
{
    RateStyleNone=0,
    RateStyleWholeStar = 1, //只能整星评论
    RateStyleHalfStar = 2,  //允许半星评论
    RateStyleIncompleteStar = 3  //允许不完整星评论
};
@protocol QYStarReplayDelegate <NSObject>

-(void)starRateView:(QYStarReplay *)starReplay currentScore:(CGFloat)currentScore;

@end
@interface QYStarReplay : UIView

@property (nonatomic,assign)BOOL isAnimation;       //是否动画显示，默认NO
@property (nonatomic,assign)RateStyle rateStyle;    //评分样式    RateStyleNone
@property (nonatomic, weak) id<QYStarReplayDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame;

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate;


-(instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish;
-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish;
@end;
