//
//  GetGroupInfoModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetGroupInfoModel : NSObject
@property(nonatomic,strong)NSString *groupCreate;
@property(nonatomic,strong)NSString *groupIcon;
@property(nonatomic,strong)NSString *groupId;
@property(nonatomic,strong)NSString *groupInfo;
@property(nonatomic,strong)NSString *groupIsCreate;
@property(nonatomic,strong)NSString *groupIsJoin;
@property(nonatomic,strong)NSString *groupName;
@property(nonatomic,strong)NSString *groupRoleType;
@property(nonatomic,strong)NSString *groupTuijian;
@property(nonatomic,strong)NSString *groupType;
@property(nonatomic,strong)NSString *groupTypeName;
@property(nonatomic,strong)NSString *groupUserNum;

+(id)loadWithJSOn:(NSDictionary *)json;

@end
