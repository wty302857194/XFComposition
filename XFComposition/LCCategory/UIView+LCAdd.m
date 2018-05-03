//
//  UIView+LCAdd.m
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/28.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import "UIView+LCAdd.h"

@implementation UIView (LCAdd)

- (void)lc_borderWithColor:(UIColor *)color radiuce:(CGFloat)radiuce {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = radiuce;
    self.layer.masksToBounds = YES;
}

- (void)lc_shadowWithColor:(UIColor *)shadowColor offset:(CGSize)offset opacity:(CGFloat)opacity {
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
}




/******************************设置View左边x坐标*******************************/
- (CGFloat)lc_left {
    return self.frame.origin.x;
}


- (void)setLc_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

/****************************设置View顶部y坐标*********************************/
- (CGFloat)lc_top {
    return self.frame.origin.y;
}

- (void)setLc_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

/****************************设置View右边x坐标*********************************/
- (CGFloat)lc_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLc_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

/****************************设置View底部y坐标*************************************/
- (CGFloat)lc_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLc_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

/*****************************设置View的中心坐标********************************/
- (CGFloat)lc_centerX {
    return self.center.x;
}

- (void)setLc_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)lc_centerY {
    return self.center.y;
}

- (void)setLc_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

/**************************设置View的宽度***********************************/
- (CGFloat)lc_width {
    return self.frame.size.width;
}

- (void)setLc_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

/*****************************设置View的高度********************************/
- (CGFloat)lc_height {
    return self.frame.size.height;
}

- (void)setLc_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (UIViewController *)lc_getViewController
{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        } else {
            next = [next nextResponder];
        }
    } while (next != nil);
    
    return nil;
}
- (UIResponder *)lc_getFirstResponder
{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isFirstResponder]) {
            return (UIViewController *)next;
        } else {
            next = [next nextResponder];
        }
    } while (next != nil);
    
    return nil;
}

- (NSObject *)lc_getSpecifyObject:(Class)cls
{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:cls]) {
            return (NSObject *)next;
        } else {
            next = [next nextResponder];
        }
    } while (next != nil);
    
    return nil;
}


- (UICollectionView *)lc_getCollectionView
{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UICollectionView class]]) {
            return (UICollectionView *)next;
        } else {
            next = [next nextResponder];
        }
    } while (next != nil);
    
    return nil;
}

- (UITableView *)lc_getTableView
{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UITableView class]]) {
            return (UITableView *)next;
        } else {
            next = [next nextResponder];
        }
    } while (next != nil);
    
    return nil;
}




- (void)drawDashedWidthRadius:(CGFloat)radius
                        color:(UIColor *)color
                    lineWidth:(CGFloat)lineWidth
              lineDashPattern:(NSArray<NSNumber *> *)lineDashPattern
{
    //border definitions
    CGFloat cornerRadius = radius;
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = color.CGColor;
    border.fillColor = nil;
    
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //围绕这个View画这个路径
    CGPathMoveToPoint(path, NULL, 0, self.frame.size.height - cornerRadius);
    CGPathAddLineToPoint(path, NULL, 0, cornerRadius);
    CGPathAddArc(path, NULL, cornerRadius, cornerRadius, cornerRadius, M_PI, -M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, self.frame.size.width - cornerRadius, 0);
    CGPathAddArc(path, NULL, self.frame.size.width - cornerRadius,
                 cornerRadius, cornerRadius, -M_PI_2, 0, NO);
    
    CGPathAddLineToPoint(path, NULL, self.frame.size.width,
                         self.frame.size.height - cornerRadius);
    
    CGPathAddArc(path, NULL,self.frame.size.width - cornerRadius,
                 self.frame.size.height - cornerRadius, cornerRadius, 0, M_PI_2, NO);
    
    CGPathAddLineToPoint(path, NULL, cornerRadius, self.frame.size.height);
    CGPathAddArc(path, NULL, cornerRadius,self.frame.size.height - cornerRadius,
                 cornerRadius, M_PI_2, M_PI, NO);
    
    border.path = path;
    CGPathRelease(path);
    border.frame = self.bounds;
    border.lineWidth = lineWidth;
    border.lineCap = @"square";
    border.lineDashPattern = lineDashPattern;
    [self.layer addSublayer:border];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
}

- (void)lc_addTapGestureWithTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}
 
@end
