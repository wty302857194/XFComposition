//
//  UIImage+Extension.m
//  穿名堂
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 zfc. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (instancetype)imageWithOriginalImageName:(NSString *)imageName{
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithResizeImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
    return [image stretchableImageWithLeftCapWidth:imageW / 2 topCapHeight:imageH / 2];
}

@end
