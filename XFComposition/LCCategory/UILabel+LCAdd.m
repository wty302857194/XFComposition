//
//  UILabel+LCAdd.m
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/28.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import "UILabel+LCAdd.h"

@implementation UILabel (LCAdd)

+ (UILabel *)lc_labelWithFont:(UIFont *)font text:(NSString *)text {
    UILabel *lbl = [[UILabel alloc]init];
    lbl.text = text;
    
    if (font) {
         lbl.font = font;
    }

    return lbl;
}

@end
