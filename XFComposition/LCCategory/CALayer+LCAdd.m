//
//  CALayer+LCAdd.m
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/28.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import "CALayer+LCAdd.h"

@implementation CALayer (LCAdd)

- (void)lc_shadowWithColor:(UIColor *)shadowColor offset:(CGSize)offset opacity:(CGFloat)opacity {
    self.shadowOffset = offset;
    self.shadowColor = shadowColor.CGColor;
    self.shadowOpacity = opacity;
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
    return self.position.x;
}

- (void)setLc_centerX:(CGFloat)centerX {
    self.position = CGPointMake(centerX, self.position.y);
}

- (CGFloat)lc_centerY {
    return self.position.y;
}

- (void)setLc_centerY:(CGFloat)centerY {
    self.position = CGPointMake(self.position.x, centerY);
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
@end
