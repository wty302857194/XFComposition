//
//  PersonModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.InTime = dic[@"InTime"];
        self.LastLoginTime = dic[@"LastLoginTime"];
        self.LoginTimes = dic[@"LoginTimes"];
        self.U_VipScore = dic[@"U_VipScore"];
        self.UserDepID = dic[@"UserDepID"];
        
        self.birthDay = dic[@"birthDay"];
        self.classId = dic[@"classId"];
        self.dutyId = dic[@"dutyId"];
        self.gyzSoft = dic[@"gyzSoft"];
        
        self.hjyid = dic[@"hjyid"];
        self.personid = dic[@"id"];
        self.jifenSoft = dic[@"jifenSoft"];
        self.realName = dic[@"realName"];
        self.roleid = dic[@"roleid"];
        self.schoolId = dic[@"schoolId"];
        
        
        self.schoolName = dic[@"schoolName"];
        self.sex = dic[@"sex"];
        self.sid = dic[@"sid"];
        self.signatrueName = dic[@"signatrueName"];
        self.u_classid = dic[@"u_classid"];
        
        self.uscore = dic[@"uscore"];
        self.userFace = dic[@"userFace"];
        self.userGuid = dic[@"userGuid"];
        self.userId = dic[@"userId"];
        self.userName = dic[@"userName"];
        
        self.useremail = dic[@"useremail"];
        self.xfbnSoft = [dic[@"xfbnSoft"] integerValue];
    }
    return self;
}

@end
