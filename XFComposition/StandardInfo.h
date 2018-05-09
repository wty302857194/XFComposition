//
//  StandardInfo.h
//  XFComposition
//
//  Created by qiannian on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "FMBean.h"

@interface StandardInfo : FMBean
@property (nonatomic,copy)NSString *StandardId;
@property (nonatomic,copy)NSString *StandardText;
@property (nonatomic,copy)NSString *ObjectId;
@property (nonatomic,copy)NSString *ModelId;
@property (nonatomic,copy)NSString *IsSystem;
@property (nonatomic,copy)NSString *Status;
@property (nonatomic,copy)NSString *AddUser;
@property (nonatomic,copy)NSString *AddTime;
@end
