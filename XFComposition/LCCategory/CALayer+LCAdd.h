//
//  CALayer+LCAdd.h
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/28.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (LCAdd)

@property (nonatomic,assign) CGFloat lc_height;
@property (nonatomic,assign) CGFloat lc_width;
@property (nonatomic,assign) CGFloat lc_left;
@property (nonatomic,assign) CGFloat lc_bottom;
@property (nonatomic,assign) CGFloat lc_right;
@property (nonatomic,assign) CGFloat lc_top;
@property (nonatomic,assign) CGFloat lc_centerX;
@property (nonatomic,assign) CGFloat lc_centerY;


- (void)lc_shadowWithColor:(UIColor *)shadowColor offset:(CGSize)offset opacity:(CGFloat)opacity;

@end
