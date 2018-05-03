//
//  UIButton+LCAdd.m
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/28.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import "UIButton+LCAdd.h"

static char buttonKey;

@implementation UIButton (LCAdd)

//+ (void)load
//{
//    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
//    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
//    method_exchangeImplementations(imp, myImp);
//}

//- (id)myInitWithCoder:(NSCoder*)aDecode
//{
//    [self myInitWithCoder:aDecode];
//    if (self) {
//        CGFloat fontSize = self.titleLabel.font.pointSize;
//        self.titleLabel.font = [UIFont systemFontOfSize:14];
//    }
//    return self;
//}

+ (UIButton *)lc_buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTintColor:[UIColor clearColor]];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"button_helight_bg"] forState:UIControlStateHighlighted];
    
    if (titleColor) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }

    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    if (font) {
        btn.titleLabel.font = font;
    }

    return btn;
}

+ (UIButton *)lc_buttonWithNormalImage:(UIImage *)nImage selectedImage:(UIImage *)sImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTintColor:[UIColor clearColor]];
    
    if (nImage) {
        [btn setImage:[nImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if (sImage) {
        [btn setImage:[sImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState: UIControlStateSelected];
    }

    return btn;
}


+ (UIButton *)lc_buttonWithNormalBGImage:(UIImage *)nImage selectedBGImage:(UIImage *)sImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTintColor:[UIColor clearColor]];
    
    [btn setBackgroundImage:[nImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                   forState: UIControlStateNormal];
    
    [btn setBackgroundImage:[sImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                   forState: UIControlStateNormal];
  

    return btn;
}




- (void)lc_handle:(void(^)(void))block {
    [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(self, &buttonKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)buttonClick:(UIButton*)button {
    void(^block)(void)  = objc_getAssociatedObject(self, &buttonKey);
    if (block != nil) {
        block();
    }
}

- (void)lc_layoutButtonWithEdgeInsetsStyle:(PNButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case PNButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case PNButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case PNButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case PNButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}



// 设置背景颜色for state
- (void)lc_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}
// 设置颜色
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end




