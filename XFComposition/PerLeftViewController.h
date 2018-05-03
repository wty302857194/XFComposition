//
//  PerLeftViewController.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/24.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"
@interface PerLeftViewController : UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>
@property (nonatomic,weak) ICSDrawerController *drawer;
@end
