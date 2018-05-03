//
//  UIImage+Extension.h
//  穿名堂
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 zfc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (instancetype)imageWithOriginalImageName:(NSString *)imageName;

+ (instancetype)imageWithResizeImageName:(NSString *)imageName;

@end
