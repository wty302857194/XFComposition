//
//  HBDrawingBoard.m
//  DemoAntiAliasing
//
//  Created by 伍宏彬 on 15/11/2.
//  Copyright (c) 2015年 HB. All rights reserved.
//

#import "HBDrawingBoard.h"
#import "UIView+WHB.h"
#import "UIColor+help.h"
#import "HBDrawPoint.h"
#import "MJExtension.h"
#import "NSFileManager+Helper.h"
#import "YasicClipAreaLayer.h"
#import "ActionSheetView.h"
#import "YasicPanGestureRecognizer.h"
typedef NS_ENUM(NSInteger, ACTIVEGESTUREVIEW) {
    CROPVIEWLEFT,
    CROPVIEWRIGHT,
    CROPVIEWTOP,
    CROPVIEWBOTTOM,
    BIGIMAGEVIEW
};

@interface HBDrawingBoard()
{
    UIColor *_lastColor;
    CGFloat _lastLineWidth;
    
 

}

@property (nonatomic, strong) NSMutableArray *paths;

@property (nonatomic, strong) NSMutableArray *tempPoints;

@property (nonatomic, strong) NSMutableArray *tempPath;

@property (nonatomic, strong) HBDrawView *drawView;

@property (nonatomic, strong) UIImage *sourceImg;

@property(strong, nonatomic) UIView *cropView;

@property(assign, nonatomic) ACTIVEGESTUREVIEW activeGestureView;

@property (nonatomic, strong)  YasicClipAreaLayer * yasiclayer ;
@property (nonatomic, strong)  UIPinchGestureRecognizer *pinGestu;
@property (nonatomic, strong)  YasicPanGestureRecognizer *panGesture;


// 图片 view 原始 frame
@property(assign, nonatomic) CGRect originalFrame;

// 裁剪区域属性
@property(assign, nonatomic) CGFloat cropAreaX;
@property(assign, nonatomic) CGFloat cropAreaY;
@property(assign, nonatomic) CGFloat cropAreaWidth;
@property(assign, nonatomic) CGFloat cropAreaHeight;

@property(nonatomic, assign) CGFloat clipHeight;
@property(nonatomic, assign) CGFloat clipWidth;



@end

#define ThumbnailPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"HBThumbnail"]

@implementation HBDrawingBoard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
//        self.backgroundColor = [UIColor blackColor];
        
     
        
        self.clipWidth = kScreenWidth;
        self.clipHeight = self.clipWidth * 9/16;
        
        self.cropAreaX = (kScreenWidth - self.clipWidth)/2;
        self.cropAreaY = (self.frame.size.height - self.clipHeight)/2;
        self.cropAreaWidth = self.clipWidth;
        self.cropAreaHeight = self.clipHeight;
        
        
        CGFloat tempWidth = 0.0;
        CGFloat tempHeight = 0.0;
        
        if (self.backImage.size.width/self.cropAreaWidth <= self.backImage.size.height/self.cropAreaHeight) {
            tempWidth = self.cropAreaWidth;
            tempHeight = (tempWidth/self.backImage.size.width) * self.backImage.size.height;
        } else if (self.backImage.size.width/self.cropAreaWidth > self.backImage.size.height/self.cropAreaHeight) {
            tempHeight = self.cropAreaHeight;
            tempWidth = (tempHeight/self.backImage.size.height) * self.backImage.size.width;
        }
        
        
        self.originalFrame = CGRectMake(self.cropAreaX - (tempWidth - self.cropAreaWidth)/2, self.cropAreaY - (tempHeight - self.cropAreaHeight)/2, tempWidth, tempHeight);
        
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.backImage];
        
        
        [self.backImage addSubview:self.drawView];
        [self addSubview:self.cropView];

        // 捏合手势
        _pinGestu = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleCenterPinGesture:)];
        [self addGestureRecognizer:_pinGestu];
        
        // 拖动手势
        _panGesture = [[YasicPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDynamicPanGesture:) inview:self.cropView];
        [self addGestureRecognizer:_panGesture];
        
        
        [self setUpCropLayer];

        
    }
    return self;
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
   
}

-(void)showCropView{
    
   
    
    _isDraw = NO;
    
    [self.cropView.layer addSublayer:_yasiclayer];
    
    [self bringSubviewToFront:self.cropView];
  
    _panGesture.enabled = YES;
    _pinGestu.enabled = YES;

}
-(void)closeCropView{
    
    
    [_yasiclayer removeFromSuperlayer];
    _panGesture.enabled = NO;
    _pinGestu.enabled = NO;

    
}
- (void)setUpCropLayer
{
    self.cropView.layer.sublayers = nil;
    
    _yasiclayer = [[YasicClipAreaLayer alloc] init];
    
    CGRect cropframe = CGRectMake(self.cropAreaX, self.cropAreaY, self.cropAreaWidth, self.cropAreaHeight);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.cropView.frame cornerRadius:0];
    UIBezierPath * cropPath = [UIBezierPath bezierPathWithRect:cropframe];
    [path appendPath:cropPath];
    _yasiclayer.path = path.CGPath;
    
    _yasiclayer.fillRule = kCAFillRuleEvenOdd;
    _yasiclayer.fillColor = [[UIColor blackColor] CGColor];
    _yasiclayer.opacity = 0.5;
    
    _yasiclayer.frame = self.cropView.bounds;
    [_yasiclayer setCropAreaLeft:self.cropAreaX CropAreaTop:self.cropAreaY CropAreaRight:self.cropAreaX + self.cropAreaWidth CropAreaBottom:self.cropAreaY + self.cropAreaHeight];
    
    
}

- (UIView *)cropView
{
    if (!_cropView) {
        _cropView = [[UIView alloc] init];
        _cropView.frame = self.bounds;
    }
    return _cropView;
}

-(void)handleDynamicPanGesture:(YasicPanGestureRecognizer *)panGesture
{
    UIView * view = self.backImage;
    CGPoint translation = [panGesture translationInView:view.superview];
    
    CGPoint beginPoint = panGesture.beginPoint;
    CGPoint movePoint = panGesture.movePoint;
    CGFloat judgeWidth = 20;
    
    // 开始滑动时判断滑动对象是 ImageView 还是 Layer 上的 Line
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        if (beginPoint.x >= self.cropAreaX - judgeWidth && beginPoint.x <= self.cropAreaX + judgeWidth && beginPoint.y >= self.cropAreaY && beginPoint.y <= self.cropAreaY + self.cropAreaHeight && self.cropAreaWidth >= 50) {
            self.activeGestureView = CROPVIEWLEFT;
        } else if (beginPoint.x >= self.cropAreaX + self.cropAreaWidth - judgeWidth && beginPoint.x <= self.cropAreaX + self.cropAreaWidth + judgeWidth && beginPoint.y >= self.cropAreaY && beginPoint.y <= self.cropAreaY + self.cropAreaHeight &&  self.cropAreaWidth >= 50) {
            self.activeGestureView = CROPVIEWRIGHT;
        } else if (beginPoint.y >= self.cropAreaY - judgeWidth && beginPoint.y <= self.cropAreaY + judgeWidth && beginPoint.x >= self.cropAreaX && beginPoint.x <= self.cropAreaX + self.cropAreaWidth && self.cropAreaHeight >= 50) {
            self.activeGestureView = CROPVIEWTOP;
        } else if (beginPoint.y >= self.cropAreaY + self.cropAreaHeight - judgeWidth && beginPoint.y <= self.cropAreaY + self.cropAreaHeight + judgeWidth && beginPoint.x >= self.cropAreaX && beginPoint.x <= self.cropAreaX + self.cropAreaWidth && self.cropAreaHeight >= 50) {
            self.activeGestureView = CROPVIEWBOTTOM;
        } else {
            self.activeGestureView = BIGIMAGEVIEW;
            [view setCenter:CGPointMake(view.center.x + translation.x, view.center.y + translation.y)];
            [panGesture setTranslation:CGPointZero inView:view.superview];
        }
    }
    
    // 滑动过程中进行位置改变
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGFloat diff = 0;
        switch (self.activeGestureView) {
            case CROPVIEWLEFT: {
                diff = movePoint.x - self.cropAreaX;
                if (diff >= 0 && self.cropAreaWidth > 50) {
                    self.cropAreaWidth -= diff;
                    self.cropAreaX += diff;
                } else if (diff < 0 && self.cropAreaX > self.backImage.frame.origin.x && self.cropAreaX >= 15) {
                    self.cropAreaWidth -= diff;
                    self.cropAreaX += diff;
                }
                [self setUpCropLayer];
                break;
            }
            case CROPVIEWRIGHT: {
                diff = movePoint.x - self.cropAreaX - self.cropAreaWidth;
                if (diff >= 0 && (self.cropAreaX + self.cropAreaWidth) < MIN(self.backImage.frame.origin.x + self.backImage.frame.size.width, self.cropView.frame.origin.x + self.cropView.frame.size.width - 15)){
                    self.cropAreaWidth += diff;
                } else if (diff < 0 && self.cropAreaWidth >= 50) {
                    self.cropAreaWidth += diff;
                }
                [self setUpCropLayer];
                break;
            }
            case CROPVIEWTOP: {
                diff = movePoint.y - self.cropAreaY;
                if (diff >= 0 && self.cropAreaHeight > 50) {
                    self.cropAreaHeight -= diff;
                    self.cropAreaY += diff;
                } else if (diff < 0 && self.cropAreaY > self.backImage.frame.origin.y && self.cropAreaY >= 15) {
                    self.cropAreaHeight -= diff;
                    self.cropAreaY += diff;
                }
                [self setUpCropLayer];
                break;
            }
            case CROPVIEWBOTTOM: {
                diff = movePoint.y - self.cropAreaY - self.cropAreaHeight;
                if (diff >= 0 && (self.cropAreaY + self.cropAreaHeight) < MIN(self.backImage.frame.origin.y + self.backImage.frame.size.height, self.cropView.frame.origin.y + self.cropView.frame.size.height - 15)){
                    self.cropAreaHeight += diff;
                } else if (diff < 0 && self.cropAreaHeight >= 50) {
                    self.cropAreaHeight += diff;
                }
                [self setUpCropLayer];
                break;
            }
            case BIGIMAGEVIEW: {
                [view setCenter:CGPointMake(view.center.x + translation.x, view.center.y + translation.y)];
                [panGesture setTranslation:CGPointZero inView:view.superview];
                break;
            }
            default:
                break;
        }
    }
    
    // 滑动结束后进行位置修正
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        switch (self.activeGestureView) {
            case CROPVIEWLEFT: {
                if (self.cropAreaWidth < 50) {
                    self.cropAreaX -= 50 - self.cropAreaWidth;
                    self.cropAreaWidth = 50;
                }
                if (self.cropAreaX < MAX(self.backImage.frame.origin.x, 15)) {
                    CGFloat temp = self.cropAreaX + self.cropAreaWidth;
                    self.cropAreaX = MAX(self.backImage.frame.origin.x, 15);
                    self.cropAreaWidth = temp - self.cropAreaX;
                }
                [self setUpCropLayer];
                break;
            }
            case CROPVIEWRIGHT: {
                if (self.cropAreaWidth < 50) {
                    self.cropAreaWidth = 50;
                }
                if (self.cropAreaX + self.cropAreaWidth > MIN(self.backImage.frame.origin.x + self.backImage.frame.size.width, self.cropView.frame.origin.x + self.cropView.frame.size.width - 15)) {
                    self.cropAreaWidth = MIN(self.backImage.frame.origin.x + self.backImage.frame.size.width, self.cropView.frame.origin.x + self.cropView.frame.size.width - 15) - self.cropAreaX;
                }
                [self setUpCropLayer];
                break;
            }
            case CROPVIEWTOP: {
                if (self.cropAreaHeight < 50) {
                    self.cropAreaY -= 50 - self.cropAreaHeight;
                    self.cropAreaHeight = 50;
                }
                if (self.cropAreaY < MAX(self.backImage.frame.origin.y, 15)) {
                    CGFloat temp = self.cropAreaY + self.cropAreaHeight;
                    self.cropAreaY = MAX(self.backImage.frame.origin.y, 15);
                    self.cropAreaHeight = temp - self.cropAreaY;
                }
                [self setUpCropLayer];
                break;
            }
            case CROPVIEWBOTTOM: {
                if (self.cropAreaHeight < 50) {
                    self.cropAreaHeight = 50;
                }
                if (self.cropAreaY + self.cropAreaHeight > MIN(self.backImage.frame.origin.y + self.backImage.frame.size.height, self.cropView.frame.origin.y + self.cropView.frame.size.height - 15)) {
                    self.cropAreaHeight = MIN(self.backImage.frame.origin.y + self.backImage.frame.size.height, self.cropView.frame.origin.y + self.cropView.frame.size.height - 15) - self.cropAreaY;
                }
                [self setUpCropLayer];
                break;
            }
            case BIGIMAGEVIEW: {
                CGRect currentFrame = view.frame;
                
                if (currentFrame.origin.x >= self.cropAreaX) {
                    currentFrame.origin.x = self.cropAreaX;
                    
                }
                if (currentFrame.origin.y >= self.cropAreaY) {
                    currentFrame.origin.y = self.cropAreaY;
                }
                if (currentFrame.size.width + currentFrame.origin.x < self.cropAreaX + self.cropAreaWidth) {
                    CGFloat movedLeftX = fabs(currentFrame.size.width + currentFrame.origin.x - (self.cropAreaX + self.cropAreaWidth));
                    currentFrame.origin.x += movedLeftX;
                }
                if (currentFrame.size.height + currentFrame.origin.y < self.cropAreaY + self.cropAreaHeight) {
                    CGFloat moveUpY = fabs(currentFrame.size.height + currentFrame.origin.y - (self.cropAreaY + self.cropAreaHeight));
                    currentFrame.origin.y += moveUpY;
                }
                [UIView animateWithDuration:0.3 animations:^{
                    
                    [view setFrame:currentFrame];
                }];
                break;
            }
            default:
                break;
        }
    }
}

-(void)handleCenterPinGesture:(UIPinchGestureRecognizer *)pinGesture
{
    CGFloat scaleRation = 3;
    UIView * view = self.backImage;
    
    // 缩放开始与缩放中
    if (pinGesture.state == UIGestureRecognizerStateBegan || pinGesture.state == UIGestureRecognizerStateChanged) {
        // 移动缩放中心到手指中心
        CGPoint pinchCenter = [pinGesture locationInView:view.superview];
        CGFloat distanceX = view.frame.origin.x - pinchCenter.x;
        CGFloat distanceY = view.frame.origin.y - pinchCenter.y;
        CGFloat scaledDistanceX = distanceX * pinGesture.scale;
        CGFloat scaledDistanceY = distanceY * pinGesture.scale;
        CGRect newFrame = CGRectMake(view.frame.origin.x + scaledDistanceX - distanceX, view.frame.origin.y + scaledDistanceY - distanceY, view.frame.size.width * pinGesture.scale, view.frame.size.height * pinGesture.scale);
        view.frame = newFrame;
        pinGesture.scale = 1;
    }
    
    // 缩放结束
    if (pinGesture.state == UIGestureRecognizerStateEnded) {
        CGFloat ration =  view.frame.size.width / self.originalFrame.size.width;
        
        // 缩放过大
        if (ration > 5) {
            CGRect newFrame = CGRectMake(0, 0, self.originalFrame.size.width * scaleRation, self.originalFrame.size.height * scaleRation);
            view.frame = newFrame;
        }
        
        // 缩放过小
        if (ration < 0.25) {
            view.frame = self.originalFrame;
        }
        // 对图片进行位置修正
        CGRect resetPosition = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        
        if (resetPosition.origin.x >= self.cropAreaX) {
            resetPosition.origin.x = self.cropAreaX;
        }
        if (resetPosition.origin.y >= self.cropAreaY) {
            resetPosition.origin.y = self.cropAreaY;
        }
        if (resetPosition.size.width + resetPosition.origin.x < self.cropAreaX + self.cropAreaWidth) {
            CGFloat movedLeftX = fabs(resetPosition.size.width + resetPosition.origin.x - (self.cropAreaX + self.cropAreaWidth));
            resetPosition.origin.x += movedLeftX;
        }
        if (resetPosition.size.height + resetPosition.origin.y < self.cropAreaY + self.cropAreaHeight) {
            CGFloat moveUpY = fabs(resetPosition.size.height + resetPosition.origin.y - (self.cropAreaY + self.cropAreaHeight));
            resetPosition.origin.y += moveUpY;
        }
        view.frame = resetPosition;
        
        // 对图片缩放进行比例修正，防止过小
        if (self.cropAreaX < self.backImage.frame.origin.x
            || ((self.cropAreaX + self.cropAreaWidth) > self.backImage.frame.origin.x + self.backImage.frame.size.width)
            || self.cropAreaY < self.backImage.frame.origin.y
            || ((self.cropAreaY + self.cropAreaHeight) > self.backImage.frame.origin.y + self.backImage.frame.size.height)) {
            view.frame = self.originalFrame;
        }
    }
}
// 裁剪图片并调用返回Block
- (void)cropImage
{
    CGFloat imageScale = MIN(self.backImage.frame.size.width/self.backImage.size.width, self.backImage.frame.size.height/self.backImage.size.height);
    CGFloat cropX = (self.cropAreaX - self.backImage.frame.origin.x)/imageScale;
    CGFloat cropY = (self.cropAreaY - self.backImage.frame.origin.y)/imageScale;
    CGFloat cropWidth = self.cropAreaWidth/imageScale;
    CGFloat cropHeight = self.cropAreaHeight/imageScale;
    CGRect cropRect = CGRectMake(cropX, cropY, cropWidth, cropHeight);
    
    UIImage *newImage = [self cropImage:self.backImage.image toRect:cropRect];
    ActionSheetView * actionSheet = [[ActionSheetView alloc] initWithCancleTitle:@"取消" otherTitles:@"范文库",@"病文库" ,nil];

    [actionSheet show];
    actionSheet.actionSheetBlock = ^(ActionSheetItem *sheetItem) {
        if (_imgeBlock) {
            _imgeBlock(sheetItem.index,newImage);
        }
    };
    
}
- (UIImage *)cropImage:(UIImage*)image toRect:(CGRect)rect {
    CGFloat (^rad)(CGFloat) = ^CGFloat(CGFloat deg) {
        return deg / 180.0f * (CGFloat) M_PI;
    };
    
    // determine the orientation of the image and apply a transformation to the crop rectangle to shift it to the correct position
    CGAffineTransform rectTransform;
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(rad(90)), 0, -image.size.height);
            break;
        case UIImageOrientationRight:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(rad(-90)), -image.size.width, 0);
            break;
        case UIImageOrientationDown:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(rad(-180)), -image.size.width, -image.size.height);
            break;
        default:
            rectTransform = CGAffineTransformIdentity;
    };
    
    // adjust the transformation scale based on the image scale
    rectTransform = CGAffineTransformScale(rectTransform, image.scale, image.scale);
    
    // apply the transformation to the rect to create a new, shifted rect
    CGRect transformedCropSquare = CGRectApplyAffineTransform(rect, rectTransform);
    // use the rect to crop the image
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, transformedCropSquare);
    // create a new UIImage and set the scale and orientation appropriately
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    // memory cleanup
    CGImageRelease(imageRef);
    
    return result;
}

#pragma mark - Public_Methd
- (BOOL)drawWithPoints:(HBDrawModel *)model{

    self.userInteractionEnabled = NO;
    
    //比值
    CGFloat xPix = ([UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale);
    CGFloat yPix = ([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale);
    CGFloat xp = model.width.floatValue / xPix;
    CGFloat yp = model.height.floatValue / yPix;
    
    HBDrawPoint *point = [model.pointList firstObject];
    
    HBPath *path = [HBPath pathToPoint:CGPointMake(point.x.floatValue * xp , point.y.floatValue * yp) pathWidth:model.paintSize.floatValue isEraser:model.isEraser.boolValue];
    path.pathColor = [UIColor colorWithHexString:model.paintColor];
    
    [self.paths addObject:path];
    
    NSMutableArray *marray = [model.pointList mutableCopy];
    
    [marray removeObjectAtIndex:0];

    [marray enumerateObjectsUsingBlock:^(HBDrawPoint *point, NSUInteger idx, BOOL *stop) {
        
        [path pathLineToPoint:CGPointMake(point.x.floatValue * xp , point.y.floatValue * yp) WithType:HBDrawingShapeCurve];
        
        [self.drawView setBrush:path];
        
    }];
    
    self.userInteractionEnabled = YES;
    return YES;
}
+ (HBDrawModel *)objectWith:(NSDictionary *)dic
{
    return [HBDrawModel objectWithKeyValues:dic];
}

#pragma mark - CustomMethd
- (CGPoint)getTouchSet:(NSSet *)touches{
    
    UITouch *touch = [touches anyObject];
     return [touch locationInView:self.backImage];

}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [self getTouchSet:touches];

    if (!_isDraw) {
        return;
    }
    
    HBPath *path = [HBPath pathToPoint:point pathWidth:_lineWidth isEraser:self.ise];

    path.pathColor = _lineColor;
    
    path.imagePath = [NSString stringWithFormat:@"%@.png",[self getTimeString]];
    
    [self.paths addObject:path];

    [self.tempPoints addObject:[HBDrawPoint drawPoint:point]];
    
    if ([self.delegate respondsToSelector:@selector(drawBoard:drawingStatus:model:)]) {
        [self.delegate drawBoard:self drawingStatus:HBDrawingStatusBegin model:nil];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

    CGPoint point = [self getTouchSet:touches];
    if (!_isDraw) {
        return;
    }
    HBPath *path = [self.paths lastObject];
    
    [path pathLineToPoint:point WithType:self.shapType];
    
    if (self.ise) {
        [self setEraseBrush:path];
    }else{
        [self.drawView setBrush:path];
    }
    
    [self.tempPoints addObject:[HBDrawPoint drawPoint:point]];
    
    if ([self.delegate respondsToSelector:@selector(drawBoard:drawingStatus:model:)]) {
        [self.delegate drawBoard:self drawingStatus:HBDrawingStatusMove model:nil];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
    
    HBPath *path = [self.paths lastObject];
    
    UIImage *image = [self screenshot:self.backImage];
    
    self.backImage.image = image;
    
    [self.drawView setBrush:nil];
    
    NSData *imageData = UIImagePNGRepresentation(image);//UIImageJPEGRepresentation(image, 0.4);
    
    NSString *filePath = [ThumbnailPath stringByAppendingPathComponent:path.imagePath];

    BOOL isSave = [NSFileManager hb_saveData:imageData filePath:filePath];
    
    if (isSave) {
        
        NSLog(@"%@", [NSString stringWithFormat:@"保存成功: %@",filePath]);
    }
    HBDrawModel *model = [[HBDrawModel alloc] init];
    model.paintColor = [_lineColor toColorString];
    model.paintSize = @(_lineWidth);
    model.isEraser = [NSNumber numberWithBool:path.isEraser];
    model.pointList = self.tempPoints;
    model.shapType = [NSNumber numberWithInteger:self.shapType];
    
    if ([self.delegate respondsToSelector:@selector(drawBoard:drawingStatus:model:)]) {
        [self.delegate drawBoard:self drawingStatus:HBDrawingStatusEnd model:model];
    }

    //清空
    [self.tempPoints removeAllObjects];

}
- (void)setEraseBrush:(HBPath *)path{
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0);
    
    [self.backImage.image drawInRect:self.bounds];
    
    [[UIColor clearColor] set];
    
    path.bezierPath.lineWidth = _lineWidth;
    
    [path.bezierPath strokeWithBlendMode:kCGBlendModeClear alpha:1.0];
    
    [path.bezierPath stroke];
    
    self.backImage.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
}
- (UIImage *)screenshot:(UIView *)shotView{
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [shotView.layer renderInContext:context];
    
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return getImage;
}
- (NSString *)getTimeString{
    
    NSDateFormatter  *dateformatter = nil;
    if (!dateformatter) {
        dateformatter = [[NSDateFormatter alloc] init];
    }
    
    [dateformatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    
    return [dateformatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
}
#pragma mark - Lazying
- (NSMutableArray *)paths{
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}
- (NSMutableArray *)tempPoints{
    if (!_tempPoints) {
        _tempPoints = [NSMutableArray array];
    }
    return _tempPoints;
}
- (NSMutableArray *)tempPath{
    if (!_tempPath) {
        _tempPath = [NSMutableArray array];
    }
    return _tempPath;
}
- (void)setShapType:(HBDrawingShapeType)shapType{
    if (self.ise) {
        return;
    }
    _shapType = shapType;
}

- (void)setLineColor:(UIColor *)lineColor
{
    if (self.ise) {
        
        _lastColor = lineColor;
        
        return;
    }
    
    _lineColor = lineColor;
}
- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    _lastLineWidth = lineWidth;
}

- (UIImageView *)backImage
{
    if (!_backImage) {
        _backImage = [[UIImageView alloc] initWithFrame:self.bounds];

    }
    return _backImage;
}

- (HBDrawView *)drawView{
    if (!_drawView) {
        _drawView = [HBDrawView new];
        _drawView.backgroundColor = [UIColor clearColor];
        _drawView.frame = self.bounds;
        
    }
    return _drawView;
}

-(void)setBoard:(setType) type{
    
    switch (type) {
        case setTypePen:
        {
            self.ise = NO;
            self.lineColor = [UIColor whiteColor];
            self.shapType = HBDrawingShapeCurve;
            self.lineWidth = 1.5;
        }
            break;
        case setTypeCamera:
        {
            
            if ([self.delegate respondsToSelector:@selector(drawBoard:action:)]) {
                [self.delegate drawBoard:self action:actionOpenCamera];
            }
            
        }
            break;
        case setTypeAlbum:
        {
            
            if ([self.delegate respondsToSelector:@selector(drawBoard:action:)]) {
                [self.delegate drawBoard:self action:actionOpenAlbum];
            }
        }
            break;
        case setTypeSave:
        {
            UIImageWriteToSavedPhotosAlbum([self screenshot:self], nil, nil, nil);
            NSLog(@"保存成功");
        }
            break;
        case setTypeEraser:
        {
            
            if (!self.ise) {
                //保存上次绘制状态
                _lastColor = _lineColor;
                _lastLineWidth = _lineWidth;
                
                //设置橡皮擦属性
                _lineColor = [UIColor clearColor];
                
                self.ise = YES;
                
            }else{
                
                self.ise = NO;
                self.shapType = HBDrawingShapeCurve;
                _lineColor = _lastColor;
                _lineWidth = _lastLineWidth;
                
            }
            
        }
            break;
        case setTypeBack:
        {
            
            if (self.paths.count == 1) {
                
                NSLog(@"已经最后一张了，不能撤退了");
                return;
            }
            
            HBPath *lastpath = [self.paths lastObject];
            
            [self.tempPath addObject:lastpath];
            
            [self.paths removeLastObject];
            
            HBPath *path = [self.paths lastObject];
            
            UIImage *getImage = [NSFileManager hb_getImageFileName:[ThumbnailPath stringByAppendingPathComponent:path.imagePath]];
            self.backImage.image = getImage;
            
        }
            break;
        case setTyperegeneration:
        {
            
            if (self.tempPath.count == 0) {
                
                NSLog(@"已经最新一张了，不能回滚了");
                return;
            }
            
            HBPath *lastpath = [self.tempPath lastObject];
            
            [self.paths addObject:lastpath];
            
            [self.tempPath removeLastObject];
            
            HBPath *path = [self.paths lastObject];
            
            UIImage *getImage = [NSFileManager hb_getImageFileName:[ThumbnailPath stringByAppendingPathComponent:path.imagePath]];
            self.backImage.image = getImage;
            
        }
            break;
        case setTypeClearAll:
        {
            
            [self.paths removeAllObjects];
            [self.tempPath removeAllObjects];
            [self.tempPoints removeAllObjects];
            
            [NSFileManager deleteFile:ThumbnailPath];
            
            self.backImage.image = nil;
            
            
        }
            break;
            
        default:
            break;
    }

    
}

@end

#pragma mark - HBPath
@interface HBPath()

@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) CGFloat pathWidth;

@end

@implementation HBPath

+ (instancetype)pathToPoint:(CGPoint)beginPoint pathWidth:(CGFloat)pathWidth isEraser:(BOOL)isEraser
{
    HBPath *path = [[HBPath alloc] init];
    path.beginPoint = beginPoint;
    path.pathWidth = pathWidth;
    path.isEraser = isEraser;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = pathWidth;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    [bezierPath moveToPoint:beginPoint];
    path.bezierPath = bezierPath;
    
    return path;
}
//HBDrawingShapeCurve = 0,//曲线
//HBDrawingShapeLine,//直线
//HBDrawingShapeEllipse,//椭圆
//HBDrawingShapeRect,//矩形
- (void)pathLineToPoint:(CGPoint)movePoint WithType:(HBDrawingShapeType)shapeType
{
    //判断绘图类型
    _shapType = shapeType;
    switch (shapeType) {
        case HBDrawingShapeCurve:
        {
            [self.bezierPath addLineToPoint:movePoint];
        }
            break;
        case HBDrawingShapeLine:
        {
            self.bezierPath = [UIBezierPath bezierPath];
            self.bezierPath.lineCapStyle = kCGLineCapRound;
            self.bezierPath.lineJoinStyle = kCGLineJoinRound;
            self.bezierPath.lineWidth = self.pathWidth;
            [self.bezierPath moveToPoint:self.beginPoint];
            [self.bezierPath addLineToPoint:movePoint];
        }
            break;
        case HBDrawingShapeEllipse:
        {
            self.bezierPath = [UIBezierPath bezierPathWithRect:[self getRectWithStartPoint:self.beginPoint endPoint:movePoint]];
            self.bezierPath.lineCapStyle = kCGLineCapRound;
            self.bezierPath.lineJoinStyle = kCGLineJoinRound;
            self.bezierPath.lineWidth = self.pathWidth;
        }
            break;
        case HBDrawingShapeRect:
        {
            self.bezierPath = [UIBezierPath bezierPathWithOvalInRect:[self getRectWithStartPoint:self.beginPoint endPoint:movePoint]];
            self.bezierPath.lineCapStyle = kCGLineCapRound;
            self.bezierPath.lineJoinStyle = kCGLineJoinRound;
            self.bezierPath.lineWidth = self.pathWidth;
        }
            break;
        default:
            break;
    }
//    self.shape.path = self.bezierPath.CGPath;
}

- (CGRect)getRectWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CGPoint orignal = startPoint;
    if (startPoint.x > endPoint.x) {
        orignal = endPoint;
    }
    CGFloat width = fabs(startPoint.x - endPoint.x);
    CGFloat height = fabs(startPoint.y - endPoint.y);
    return CGRectMake(orignal.x , orignal.y , width, height);
}

@end

@implementation HBDrawView

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (void)setBrush:(HBPath *)path
{
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    
    shapeLayer.strokeColor = path.pathColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = path.bezierPath.lineWidth;
    ((CAShapeLayer *)self.layer).path = path.bezierPath.CGPath;
    
    
}


@end
