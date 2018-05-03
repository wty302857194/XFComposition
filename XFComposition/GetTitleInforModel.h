//
//  GetTitleInforModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/22.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTitleInforModel : NSObject
@property(nonatomic,strong)NSString *AddTime;
@property(nonatomic,strong)NSString *ContentInfo;
@property(nonatomic,strong)NSString *GroupID;
@property(nonatomic,strong)NSString *IsTop;
@property(nonatomic,strong)NSString *IsTuiJian;
@property(nonatomic,strong)NSString *ObId;
@property(nonatomic,strong)NSString *PinLunNum;
@property(nonatomic,strong)NSString *Title;
@property(nonatomic,strong)NSString *UserID;
@property(nonatomic,strong)NSString *UserName;
@property(nonatomic,strong)NSString *UserPic;
@property(nonatomic,strong)NSString *UserSayAttr;
@property(nonatomic,strong)NSString *VisitedTime;
@property(nonatomic,strong)NSString *InforId;
@property(nonatomic,strong)NSString *typeID;
+(id)loadWithJSOn:(NSDictionary *)json;

@end
