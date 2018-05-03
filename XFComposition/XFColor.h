//
//  XFColor.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#ifndef XFColor_h
#define XFColor_h


#endif /* XFColor_h */
#define Color(R, G, B)                  [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:1.0]
#define UIColorFromRGBA(R, G, B, A)             [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
