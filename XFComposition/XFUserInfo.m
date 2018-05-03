//
//  XFUserInfo.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "XFUserInfo.h"
//#import "LoginModel.h"

@implementation XFUserInfo

@synthesize userId;
@synthesize userName;

+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.birthDay = dic[@"ret_data"][@"birthDay"];
        self.classId= dic[@"ret_data"][@"classId"] ;
        self.dutyId = dic[@"ret_data"][@"dutyId"];
        self.Loginid = dic[@"ret_data"][@"id"];
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

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.birthDay forKey:@"birthDay"];
    [aCoder encodeObject:self.classId forKey:@"classId"];
    [aCoder encodeObject:self.dutyId forKey:@"dutyId"];
    [aCoder encodeObject:self.Loginid forKey:@"Loginid"];
    [aCoder encodeObject:self.realName forKey:@"realName"];
    [aCoder encodeObject:self.schoolId forKey:@"schoolId"];
    [aCoder encodeObject:self.schoolName forKey:@"schoolName"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.signatrueName forKey:@"signatrueName"];
    [aCoder encodeObject:self.userFace forKey:@"userFace"];
    [aCoder encodeObject:self.userId    forKey:@"userId"];
    [aCoder encodeObject:self.userName  forKey:@"userName"];
    
    
}

//解档
- (id)initWithCoder:(NSCoder *)aDecoder {
    self.birthDay         = [aDecoder decodeObjectForKey:@"birthDay"];
    self.classId         = [aDecoder decodeObjectForKey:@"classId"];
    self.dutyId         = [aDecoder decodeObjectForKey:@"dutyId"];
    self.Loginid         = [aDecoder decodeObjectForKey:@"Loginid"];
    self.realName         = [aDecoder decodeObjectForKey:@"realName"];
    self.schoolId         = [aDecoder decodeObjectForKey:@"schoolId"];
    self.schoolName         = [aDecoder decodeObjectForKey:@"schoolName"];
    self.sex         = [aDecoder decodeObjectForKey:@"sex"];
    self.signatrueName         = [aDecoder decodeObjectForKey:@"signatrueName"];
    self.userFace         = [aDecoder decodeObjectForKey:@"userFace"];
    self.userId         = [aDecoder decodeObjectForKey:@"userId"];
    self.userName       = [aDecoder decodeObjectForKey:@"userName"];
    
    return self;
}

// 保存登录的用户信息
+ (void)saveUserInfo:(XFUserInfo *)model {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:model];
    [defaults setObject:myEncodedObject forKey:ZSH_USERINFO_MODEL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 删除用户信息
+ (void)deleteUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:ZSH_USERINFO_MODEL];
    [defaults synchronize];
}
//
// 获取用户信息
+ (id)getUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:ZSH_USERINFO_MODEL];
    XFUserInfo *aModel = [NSKeyedUnarchiver unarchiveObjectWithData:myEncodedObject];
    return aModel;
}

// 是否已登录
+ (BOOL)isLogin {
    XFUserInfo *aModel = [self getUserInfo];
    if (aModel.Loginid) {
        return YES;
    }
    return NO;
}


@end
