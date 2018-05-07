//
//  MarkprogressViewController.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MarkprogressBlock) ();
@interface MarkprogressViewController : UIViewController
@property (nonatomic,strong)NSString *PageStr;
@property (nonatomic,strong)NSString *bookID;
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,copy) MarkprogressBlock markprogressBlock;
@property (nonatomic,strong)NSString *bjID;
@end
