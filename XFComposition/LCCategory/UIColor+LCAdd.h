//
//  UIColor+LCAdd.h
//  GBHelper
//
//  Created by lc-macbook pro on 2018/4/3.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PNRGB(R,G,B)  PNRGBA(R,G,B,1)
#define PNRGBA(R,G,B,A)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]


@interface UIColor (LCAdd)

+ (UIColor *)lc_colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b;
+ (UIColor *)lc_defaultColor;

+ (UIColor *)lc_orangeColor;

+ (UIColor *)lc_tableGroupBGColor;
+ (UIColor *)lc_defaultTableCellSeparatorColor;

+ (UIColor *)lc_grayTitleTextColor;
+ (UIColor *)lc_grayContentTextColor;

+ (UIColor *)lc_imageViewBGColor;

@end
