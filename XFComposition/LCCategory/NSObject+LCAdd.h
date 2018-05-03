//
//  NSObject+LCAdd.h
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/28.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LCAdd)

+ (instancetype)lc_allocInit;

/** 交换生成的方法 **/
+ (void)lc_swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector;
- (void)lc_swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector;


/** 动态计算 高度 宽度 **/
- (CGRect)lc_autoHeight:(NSString *)text font:(UIFont *)font width:(CGFloat)width;
- (CGRect)lc_autoHeight:(NSString *)text font:(UIFont *)font height:(CGFloat)height;


@end
