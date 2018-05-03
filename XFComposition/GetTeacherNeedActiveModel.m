//
//  GetTeacherNeedActiveModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetTeacherNeedActiveModel.h"

@implementation GetTeacherNeedActiveModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.ActiveAttribute1 = dic[@"ActiveAttribute1"];
        self.ActiveEndTime = dic[@"ActiveEndTime"];
        self.ActiveInfo = dic[@"ActiveInfo"];
        self.ActiveName = dic[@"ActiveName"];
        self.ActiveOrderID = dic[@"ActiveOrderID"];
        self.ActivePic = dic[@"ActivePic"];
        self.ActiveStartTime = dic[@"ActiveStartTime"];
        self.ActiveTypeID = dic[@"ActiveTypeID"];
        self.ID = dic[@"ID"];
        self.UserName = dic[@"UserName"];
        
        
    }
    return self;
}

@end
