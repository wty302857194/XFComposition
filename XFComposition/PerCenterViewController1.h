//
//  PerCenterViewController1.h
//  XFComposition
//
//  Created by qiannian on 2018/5/7.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface PerCenterViewController1 : UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>
@property (nonatomic,strong)NSString *typeStr;
@property (nonatomic,strong)NSString *flagStr;
@property (nonatomic,weak) ICSDrawerController *drawer;

+ (instancetype)defaultPlainViewController;
@end
