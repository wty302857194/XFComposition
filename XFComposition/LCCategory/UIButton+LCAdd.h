//
//  UIButton+LCAdd.h
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/28.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, PNButtonEdgeInsetsStyle) {
    PNButtonEdgeInsetsStyleTop, // image在上，label在下
    PNButtonEdgeInsetsStyleLeft, // image在左，label在右
    PNButtonEdgeInsetsStyleBottom, // image在下，label在上
    PNButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (LCAdd)

+ (UIButton *)lc_buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor;

+ (UIButton *)lc_buttonWithNormalImage:(UIImage *)nImage selectedImage:(UIImage *)sImage;
+ (UIButton *)lc_buttonWithNormalBGImage:(UIImage *)nImage selectedBGImage:(UIImage *)sImage;



- (void)lc_handle:(void(^)(void))block;


- (void)lc_layoutButtonWithEdgeInsetsStyle:(PNButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;


- (void)lc_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
