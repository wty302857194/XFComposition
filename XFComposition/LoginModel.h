//
//  LoginModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject


@property(nonatomic,strong)NSString *birthDay;
@property(nonatomic,strong)NSString *classId;
@property(nonatomic,strong)NSString *dutyId;
@property(nonatomic,strong)NSString *LoginId;//id
@property(nonatomic,strong)NSString *realName;
@property(nonatomic,strong)NSString *schoolId;
@property(nonatomic,strong)NSString *schoolName;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *signatrueName;
@property(nonatomic,strong)NSString *userFace;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *userName;
+(id)loadWithJSOn:(NSDictionary *)json;
@end
