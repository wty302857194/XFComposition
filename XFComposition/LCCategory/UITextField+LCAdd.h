//
//  UITextField+LCAdd.h
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/28.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LCAdd)

+ (UITextField *)lc_fieldWithPlaceHolder:(NSString *)placeHolder;

- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;

- (void)lc_setPlaceHolderTextColor:(UIColor *)color;

@end
