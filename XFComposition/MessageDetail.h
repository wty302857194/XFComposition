//
//  MessageDetail.h
//  XFComposition
//
//  Created by qiannian on 2018/5/4.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageDetail : FMBean
@property (nonatomic, copy)NSString * HSUSERID;
@property (nonatomic, copy)NSString * UserId;
@property (nonatomic, copy)NSString * UserName;
@property (nonatomic, copy)NSString * RepostUserID;
@property (nonatomic, copy)NSString * RepostTime;

@property (nonatomic, copy)NSString * Metitle;
@property (nonatomic, copy)NSString * Mecontain;
@property (nonatomic, copy)NSString * SendUserID;
@property (nonatomic, copy)NSString * SendUserName;
@end
