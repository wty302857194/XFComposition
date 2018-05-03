//
//  WaterWaveView.m
//  XPFWaterWaveView
//
//  Created by www.xpf.com on 2018/2/24.
//  Copyright © 2018年 www.xpf.com. All rights reserved.
//

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#import "WaterWaveView.h"

@interface WaterWaveView ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer *secondeWaveLayer;
@property (nonatomic, strong) CAShapeLayer *thirdWaveLayer;
@property (nonatomic, strong) CAShapeLayer *bgLayer;
@property (nonatomic, strong) CAShapeLayer *bgLayer2;
@property (nonatomic, strong) CAShapeLayer *bgLayer3;

@end


@implementation WaterWaveView {
    CGFloat _waveAmplitude1;      //!< 振幅
    CGFloat _waveAmplitude2;
    CGFloat _waveAmplitude3;
    
    CGFloat _waveCycle;          //!< 周期
    
    CGFloat _waveSpeed1;          //!< 速度
    CGFloat _waveSpeed2;
    CGFloat _waveSpeed3;
    
    CGFloat _waterWaveHeight;
    CGFloat _waterWaveWidth;
    
    CGFloat _wavePointY1;
    CGFloat _wavePointY2;
    CGFloat _wavePointY3;
    
    CGFloat _waveOffsetX1; //!< 波浪x位移
    CGFloat _waveOffsetX2;
    CGFloat _waveOffsetX3;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self ConfigParams];
        
        [self startWave];
    }
    return self;
}
- (CAShapeLayer *)bgLayer
{
    if (!_bgLayer) {
        _bgLayer = [CAShapeLayer layer];
        _bgLayer.strokeColor = [UIColor clearColor].CGColor;
        _bgLayer.fillColor = navigation_barColor(0.8).CGColor;
    }
    return _bgLayer;
}
- (CAShapeLayer *)bgLayer2
{
    if (!_bgLayer2) {
        _bgLayer2 = [CAShapeLayer layer];
        _bgLayer2.strokeColor = [UIColor clearColor].CGColor;
        _bgLayer2.fillColor = navigation_barColor(0.8).CGColor;
    }
    return _bgLayer2;
}
//- (CAShapeLayer *)bgLayer3
//{
//    if (!_bgLayer3) {
//        _bgLayer3 = [CAShapeLayer layer];
//        _bgLayer3.strokeColor = [UIColor clearColor].CGColor;
//        _bgLayer3.fillColor = rgba(91, 142, 234,0.5).CGColor;
//    }
//    return _bgLayer3;
//}
- (void)drawRect:(CGRect)rect
{
    self.layer.masksToBounds = NO;
    [self.layer addSublayer:self.bgLayer];
    [self.layer addSublayer:self.bgLayer2];
    [self.layer addSublayer:self.bgLayer3];
    [self draw:0 waveOffsetX2:0 waveOffsetX3:0];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bounds];
    imgView.image = [UIImage imageNamed:@"home_bg"];
    [self addSubview:imgView];
    
    //头像 姓名
    CGFloat imgVH = 80;
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.image = [UIImage imageNamed:@"paizhao"];
    imgV.frame = CGRectMake(kScreenWidth / 2 - imgVH / 2, 60, imgVH, imgVH);
    [self addSubview:imgV];
    [imgV lc_addTapGestureWithTarget:self action:@selector(goImgPhoto)];
    
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.frame = CGRectMake(0, CGRectGetMaxY(imgV.frame)+10, [UIScreen mainScreen].bounds.size.width, 20);
    nameLab.text = @"上 传 作 文";
    nameLab.textColor = [UIColor whiteColor];
    nameLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLab];
}
- (void)goImgPhoto
{
    if (self.goImagePhotoBlock) {
        self.goImagePhotoBlock();
    }
}
- (void)draw:(CGFloat)waveOffsetX waveOffsetX2:(CGFloat)waveOffsetX2 waveOffsetX3:(CGFloat)waveOffsetX3
{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.bounds.size.height - 20)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height - 20)];
    CGFloat yP1 = self.bounds.size.height;
    for (float x = self.bounds.size.width; x>= 0; x --) {
        yP1 = _waveAmplitude1 * sin(_waveCycle * x + waveOffsetX - 10) + _wavePointY1 + 10;
        [path addLineToPoint:CGPointMake(x, yP1)];
    }
    self.bgLayer.path = path.CGPath;
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(0, self.bounds.size.height - 20)];
    [path2 addLineToPoint:CGPointMake(0, 0)];
    [path2 addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    [path2 addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height - 20)];
    CGFloat yP2 = self.bounds.size.height;
    for (float x = self.bounds.size.width; x>= 0; x --) {
        yP2 = _waveAmplitude1 * sin(_waveCycle * x + waveOffsetX2 - 20) + _wavePointY1 + 10;
        [path2 addLineToPoint:CGPointMake(x, yP2)];
    }
    self.bgLayer2.path = path2.CGPath;
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(0, self.bounds.size.height - 20)];
    [path3 addLineToPoint:CGPointMake(0, 0)];
    [path3 addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    [path3 addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height - 20)];
    CGFloat yP3 = self.bounds.size.height;
    for (float x = self.bounds.size.width; x>= 0; x --) {
        yP3 = _waveAmplitude1 * sin(_waveCycle * x + waveOffsetX3 - 30) + _wavePointY1 + 10;
        [path3 addLineToPoint:CGPointMake(x, yP3)];
    }
    self.bgLayer3.path = path3.CGPath;
}
#pragma mark 配置参数
- (void)ConfigParams
{
    _waterWaveWidth = self.frame.size.width;
    _waterWaveHeight = 400;
    
    _waveSpeed1 = 0.02/M_PI;
    _waveSpeed2 = 0.02/M_PI;
    _waveSpeed3 = 0.04/M_PI;
    
    _waveOffsetX1 = 0;
    _waveOffsetX2 = 0;
    _waveOffsetX3 = 0;
    
    _wavePointY1 = self.bounds.size.height;
    _wavePointY2 = 100;
    _wavePointY3 = 100;
    
    _waveAmplitude1 = 5;
    _waveAmplitude2 = 5;
    _waveAmplitude3 = 50;
    _waveCycle =  2.5 * M_PI / _waterWaveWidth;
}

#pragma mark 加载layer ，绑定runloop 帧刷新
- (void)startWave
{
    
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark 帧刷新事件
- (void)getCurrentWave
{
    _waveOffsetX1 += _waveSpeed1;
    _waveOffsetX2 += _waveSpeed2;
    _waveOffsetX3 += _waveSpeed3;
    [self draw:_waveOffsetX1 waveOffsetX2:_waveOffsetX2 waveOffsetX3:_waveOffsetX3];
    
}

- (CADisplayLink *)displayLink
{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    }
    return _displayLink;
}

@end
