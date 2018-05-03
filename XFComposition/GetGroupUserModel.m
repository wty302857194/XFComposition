//
//  GetGroupUserModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetGroupUserModel.h"

@implementation GetGroupUserModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.Id = dic[@"Id"];
        self.JoinTime = dic[@"JoinTime"];
        self.RoleType = dic[@"RoleType"];
        self.TitleNum = dic[@"TitleNum"];
        self.UserID = dic[@"UserID"];
        self.UserName = dic[@"UserName"];
        self.UserPic = dic[@"UserPic"];
        
    }
    return self;
}
@end
