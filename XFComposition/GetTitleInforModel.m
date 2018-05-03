//
//  GetTitleInforModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/22.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetTitleInforModel.h"

@implementation GetTitleInforModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.AddTime = dic[@"AddTime"];
        self.ContentInfo = dic[@"ContentInfo"];
        self.GroupID = dic[@"GroupID"];
        self.IsTop = dic[@"IsTop"];
        self.IsTuiJian = dic[@"IsTuiJian"];
        self.ObId = dic[@"ObId"];
        self.PinLunNum = dic[@"PinLunNum"];
        self.Title = dic[@"Title"];
        self.UserID = dic[@"UserID"];
        self.UserName = dic[@"UserName"];
        
        self.UserPic = dic[@"UserPic"];
        self.UserSayAttr = dic[@"UserSayAttr"];
        self.VisitedTime = dic[@"VisitedTime"];
        self.InforId = dic[@"id"];
        self.typeID = dic[@"typeID"];

    }
    return self;
}

@end
