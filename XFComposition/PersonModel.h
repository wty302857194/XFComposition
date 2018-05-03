//
//  PersonModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject
@property (nonatomic,strong)NSString *InTime;
@property (nonatomic,strong)NSString *LastLoginTime;
@property (nonatomic,strong)NSString *LoginTimes;
@property (nonatomic,strong)NSString *U_VipScore;
@property (nonatomic,strong)NSString *UserDepID;

@property (nonatomic,strong)NSString *birthDay;
@property (nonatomic,strong)NSString *classId;
@property (nonatomic,strong)NSString *dutyId;
@property (nonatomic,strong)NSString *gyzSoft;
@property (nonatomic,strong)NSString *hjyid;

@property (nonatomic,strong)NSString *personid;
@property (nonatomic,strong)NSString *jifenSoft;
@property (nonatomic,strong)NSString *realName;
@property (nonatomic,strong)NSString *roleid;
@property (nonatomic,strong)NSString *schoolId;

@property (nonatomic,strong)NSString *schoolName;
@property (nonatomic,strong)NSString *sex;
@property (nonatomic,strong)NSString *sid;
@property (nonatomic,strong)NSString *signatrueName;
@property (nonatomic,strong)NSString *u_classid;

@property (nonatomic,strong)NSString *uscore;
@property (nonatomic,strong)NSString *userFace;
@property (nonatomic,strong)NSString *userGuid;
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *useremail;
@property (nonatomic,assign)NSInteger xfbnSoft;
+(id)loadWithJSOn:(NSDictionary *)json;
@end
