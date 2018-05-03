
//
//  GetGroupInfoModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetGroupInfoModel.h"

@implementation GetGroupInfoModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.groupCreate = dic[@"groupCreate"];
        self.groupIcon = dic[@"groupIcon"];
        self.groupId = dic[@"groupId"];
        self.groupInfo = dic[@"groupInfo"];
        self.groupIsCreate = dic[@"groupIsCreate"];
        self.groupIsJoin = dic[@"groupIsJoin"];
        self.groupName = dic[@"groupName"];
        self.groupRoleType = dic[@"groupRoleType"];
        self.groupTuijian = dic[@"groupTuijian"];
        self.groupType = dic[@"groupType"];
        
        self.groupTypeName = dic[@"groupTypeName"];
        self.groupUserNum = dic[@"groupUserNum"];
        
    }
    return self;
}

@end
