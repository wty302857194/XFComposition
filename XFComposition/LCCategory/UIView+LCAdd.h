//
//  UIView+LCAdd.h
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/28.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCAdd)


@property (nonatomic,assign) CGFloat lc_height;
@property (nonatomic,assign) CGFloat lc_width;
@property (nonatomic,assign) CGFloat lc_left;
@property (nonatomic,assign) CGFloat lc_bottom;
@property (nonatomic,assign) CGFloat lc_right;
@property (nonatomic,assign) CGFloat lc_top;
@property (nonatomic,assign) CGFloat lc_centerX;
@property (nonatomic,assign) CGFloat lc_centerY;

- (UIResponder *)lc_getFirstResponder;

//获取当前的 视图（table collection controller 等）
- (NSObject *)lc_getSpecifyObject:(Class)cls;

- (UIViewController *)lc_getViewController;

- (UICollectionView *)lc_getCollectionView;

- (UITableView *)lc_getTableView;



//绘制虚线
- (void)drawDashedWidthRadius:(CGFloat)radius
                        color:(UIColor *)color
                    lineWidth:(CGFloat)lineWidth
              lineDashPattern:(NSArray<NSNumber *> *)lineDashPattern;



- (void)lc_borderWithColor:(UIColor *)color radiuce:(CGFloat)radiuce;

- (void)lc_shadowWithColor:(UIColor *)shadowColor offset:(CGSize)offset opacity:(CGFloat)opacity;

- (void)lc_addTapGestureWithTarget:(id)target action:(SEL)action;

@end
