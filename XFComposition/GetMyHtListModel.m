//
//  GetMyHtListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/9.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetMyHtListModel.h"

@implementation GetMyHtListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.ActionId = dic[@"ActionId"];
        self.AddTime = dic[@"AddTime"];
        self.ContentInfo = dic[@"ContentInfo"];
        self.Id = dic[@"Id"];
        self.ObjectID = dic[@"ObjectID"];
        self.UserName = dic[@"UserName"];
        self.UserPic = dic[@"UserPic"];
        self.isTop = dic[@"isTop"];
        self.isTuiJian = dic[@"isTuiJian"];
        self.plNum = [dic[@"plNum"] integerValue];
        
        self.title = dic[@"title"];
        self.viewNum = dic[@"viewNum"];
        
    }
    return self;
}

@end
