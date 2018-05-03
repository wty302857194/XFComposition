//
//  UIColor+LCAdd.m
//  GBHelper
//
//  Created by lc-macbook pro on 2018/4/3.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import "UIColor+LCAdd.h"

@implementation UIColor (LCAdd)

+ (UIColor *)lc_colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

+ (UIColor *)lc_defaultColor {
    return PNRGB(223, 0, 17);
}

+ (UIColor *)lc_orangeColor {
    return PNRGB(252, 171, 27);
}

+ (UIColor *)lc_tableGroupBGColor {
    return PNRGB(235, 235, 241);
}
+ (UIColor *)lc_defaultTableCellSeparatorColor {
    return PNRGB(194, 192, 199);
}


+ (UIColor *)lc_grayTitleTextColor {
    return PNRGB(38, 38, 38);
}
+ (UIColor *)lc_grayContentTextColor {
    return PNRGB(85, 85, 85);
}
+ (UIColor *)lc_imageViewBGColor {
    return PNRGB(241, 241, 241);
}
@end
