//
//  CorrectViewController.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface CorrectViewController : UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>
@property (nonatomic,strong)NSString *PicID;
@property (nonatomic,strong)NSString *PicUrl;

@end
