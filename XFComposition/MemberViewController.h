//
//  MemberViewController.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetGroupInfoModel.h"
@interface MemberViewController : UIViewController
@property (nonatomic,strong)GetGroupInfoModel *Model;
@property (nonatomic,strong)NSString *groupId;
@end
