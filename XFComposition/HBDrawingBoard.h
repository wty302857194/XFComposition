//
//  HBDrawingBoard.h
//  DemoAntiAliasing
//
//  Created by 伍宏彬 on 15/11/2.
//  Copyright (c) 2015年 HB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBDrawModel.h"


typedef NS_ENUM(NSInteger,setType) {
    setTypePen,
    setTypeCamera,
    setTypeAlbum,
    setTypeSave,
    setTypeEraser,
    setTypeBack,
    setTyperegeneration,
    setTypeClearAll
};


typedef NS_ENUM(NSInteger, HBDrawingStatus)
{
    HBDrawingStatusBegin,//准备绘制
    HBDrawingStatusMove,//正在绘制
    HBDrawingStatusEnd//结束绘制

};

typedef NS_ENUM(NSInteger, HBDrawingShapeType)
{
    HBDrawingShapeCurve = 0,//曲线
    HBDrawingShapeLine,//直线
    HBDrawingShapeEllipse,//椭圆
    HBDrawingShapeRect,//矩形
    
};
typedef NS_ENUM(NSInteger, actionOpen) {
    actionOpenAlbum,
    actionOpenCamera
};




@class HBDrawingBoard;

@protocol HBDrawingBoardDelegate <NSObject>

- (void)drawBoard:(HBDrawingBoard *)drawView action:(actionOpen)action;
- (void)drawBoard:(HBDrawingBoard *)drawView drawingStatus:(HBDrawingStatus)drawingStatus model:(HBDrawModel *)model;

@end

typedef void(^YasicClipPageBlock)(NSInteger index ,UIImage*imge);


@interface HBDrawingBoard : UIView

@property (nonatomic , copy) YasicClipPageBlock  imgeBlock;

@property (nonatomic, assign) BOOL ise;

@property (nonatomic, assign) HBDrawingShapeType shapType;

@property (nonatomic, strong) UIImageView *backImage;

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, weak) id<HBDrawingBoardDelegate> delegate;

@property (nonatomic, assign) BOOL isDraw;// 是否绘画；


- (BOOL)drawWithPoints:(HBDrawModel *)model;

-(void)setBoard:(setType) type;

-(void)showCropView;
-(void)closeCropView;

+ (HBDrawModel *)objectWith:(NSDictionary *)dic;
@end

#pragma mark - HBPath
@interface HBPath : NSObject

@property (nonatomic, strong) UIColor *pathColor;//画笔颜色
@property (nonatomic, assign) CGFloat lineWidth;//线宽
@property (nonatomic, assign) BOOL isEraser;//橡皮擦
@property (nonatomic, assign) HBDrawingShapeType shapType;//绘制样式
@property (nonatomic, copy) NSString *imagePath;//图片路径
@property (nonatomic, strong) UIBezierPath *bezierPath;


+ (instancetype)pathToPoint:(CGPoint)beginPoint pathWidth:(CGFloat)pathWidth isEraser:(BOOL)isEraser;//初始化对象
- (void)pathLineToPoint:(CGPoint)movePoint WithType:(HBDrawingShapeType)shapeType;//画

@end

@interface HBDrawView : UIView

- (void)setBrush:(HBPath *)path;

@end

