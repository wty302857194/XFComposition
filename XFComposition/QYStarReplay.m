//
//  QYStarReplay.m
//  QYStarDisplay
//
//  Created by qiannian on 2018/5/9.
//  Copyright © 2018年 qiannian. All rights reserved.
//

#import "QYStarReplay.h"

typedef void(^completeBlock)(CGFloat currentScore);

@interface QYStarReplay()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;// 星星数目
@property (nonatomic,assign)CGFloat currentScore;   // 当前评分：0-5  默认0

@property (nonatomic,copy)completeBlock complete;

@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end;

@implementation QYStarReplay

-(void)dealloc{
    
    
    
}
#pragma mark - 代理方式
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = RateStyleNone;
        [self createStarView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        _rateStyle = rateStyle;
        _isAnimation = isAnimation;
        _delegate = delegate;
        [self createStarView];
    }
    return self;
}

#pragma mark - block方式
-(instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = RateStyleNone;
        _complete = ^(CGFloat currentScore){
            finish(currentScore);
        };
        [self createStarView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnimation:(BOOL)isAnimation finish:(finishBlock)finish{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        _rateStyle = rateStyle;
        _isAnimation = isAnimation;
        _complete = ^(CGFloat currentScore){
            finish(currentScore);
        };
        [self createStarView];
    }
    return self;
}

#pragma mark - private Method
-(void)createStarView{
    
    self.foregroundStarView = [self createStarViewWithImage:@"star_yellow"];
    self.backgroundStarView = [self createStarViewWithImage:@"star_gray"];
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width*_currentScore/self.numberOfStars, self.bounds.size.height);
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    _tapGesture.delegate = self;
    _tapGesture.numberOfTapsRequired = 1;
    
    _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panRateView:)];
    _pan.delegate = self;
    
    if (!_isCloseGestureRecognizer) {
        [self addGestureRecognizer:_tapGesture];
        [self addGestureRecognizer:_pan];
        
    }
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    CGPoint  point  =  [gestureRecognizer locationInView:self];
    NSLog(@"x==%f y===%f",point.x,point.y);
 
    return YES;
    
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
  
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        UIPanGestureRecognizer * pan = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint translation = [pan translationInView:self];
        
        CGFloat absX = fabs(translation.x);
        CGFloat absY = fabs(translation.y);
         if (absY > absX) {
             return NO;
         }


    }
    return YES;
    
}
-(void)setIsCloseGestureRecognizer:(BOOL)isCloseGestureRecognizer{
    
    if (isCloseGestureRecognizer) {
        [self removeGestureRecognizer:_pan];
        [self removeGestureRecognizer:_tapGesture];
    }
    _isCloseGestureRecognizer = isCloseGestureRecognizer;
    
}
// 根据分数得到星星
-(void)reloadStarWithScore:(CGFloat)score{
    
  
    switch (_rateStyle) {
        case RateStyleWholeStar:
        {
            self.currentScore = ceilf(score);
            break;
        }
        case RateStyleHalfStar:
            self.currentScore = roundf(score)>=score ? ceilf(score):(ceilf(score)-0.5);
            break;
        case RateStyleIncompleteStar:
            self.currentScore = score;
            break;
        default:
            break;
    }
}
#pragma mark -  滑动手势
-(void)panRateView:(UIPanGestureRecognizer*)gesture{
    
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    [self reloadStarWithScore:realStarScore];
    
}
#pragma mark -  点击手势
- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    [self reloadStarWithScore:realStarScore];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak QYStarReplay *weakSelf = self;
    CGFloat animationTimeInterval = self.isAnimation ? 0.1 : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.currentScore/self.numberOfStars, weakSelf.bounds.size.height);
    }];
}


-(void)setCurrentScore:(CGFloat)currentScore {
    if (_currentScore == currentScore) {
        return;
    }
    if (currentScore < 0) {
        _currentScore = 0;
    } else if (currentScore > _numberOfStars) {
        _currentScore = _numberOfStars;
    } else {
        _currentScore = currentScore;
    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:currentScore:)]) {
        [self.delegate starRateView:self currentScore:_currentScore];
    }
    
    if (self.complete) {
        _complete(_currentScore);
    }
    
    [self setNeedsLayout];
}

@end
