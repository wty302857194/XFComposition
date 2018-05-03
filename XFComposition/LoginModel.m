//
//  LoginModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.birthDay = dic[@"ret_data"][@"birthDay"];
        self.classId= dic[@"ret_data"][@"classId"] ;
        self.dutyId = dic[@"ret_data"][@"dutyId"];
        self.LoginId = dic[@"ret_data"][@"id"];
        self.realName = dic[@"ret_data"][@"realName"];
        self.schoolId = dic[@"ret_data"][@"schoolId"];
        self.schoolName = dic[@"ret_data"][@"schoolName"];
        self.sex = dic[@"ret_data"][@"sex"];
        self.signatrueName =dic[@"ret_data"][@"signatrueName"];
        self.userFace = dic[@"ret_data"][@"userFace"];
        self.userId = dic[@"ret_data"][@"userId"];
        self.userName = dic[@"ret_data"][@"userName"];
    }
    return self;
}

@end
