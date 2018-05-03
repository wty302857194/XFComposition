//
//  GetGroupUserModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetGroupUserModel : NSObject
@property(nonatomic,strong)NSString *Id;
@property(nonatomic,strong)NSString *JoinTime;
@property(nonatomic,strong)NSString *RoleType;
@property(nonatomic,strong)NSString *TitleNum;
@property(nonatomic,strong)NSString *UserID;
@property(nonatomic,strong)NSString *UserName;
@property(nonatomic,strong)NSString *UserPic;


+(id)loadWithJSOn:(NSDictionary *)json;
@end
