//
//  XFUserInfo.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ZSH_USERINFO_MODEL          @"zsh_userInfo_model"

@interface XFUserInfo : NSObject

@property(nonatomic,strong)NSString *birthDay;
@property(nonatomic,strong)NSString *classId;
@property(nonatomic,strong)NSString *dutyId;
@property(nonatomic,strong)NSString *Loginid;//id
@property(nonatomic,strong)NSString *realName;
@property(nonatomic,strong)NSString *schoolId;
@property(nonatomic,strong)NSString *schoolName;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *signatrueName;
@property(nonatomic,strong)NSString *userFace;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *userName;

// 保存登录的用户信息
+ (void)saveUserInfo:(id)model;

// 删除用户信息
+ (void)deleteUserInfo;

// 获取用户信息
+ (XFUserInfo*)getUserInfo;
//
// 是否已登录
+ (BOOL)isLogin;


+(id)loadWithJSOn:(NSDictionary *)json;
@end
