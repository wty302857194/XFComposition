//
//  GroupModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/5.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GroupModel.h"

@implementation GroupModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.GroupAddTime = dic[@"GroupAddTime"];
        self.GroupIcon = dic[@"GroupIcon"];
        self.GroupInfo = dic[@"GroupInfo"];
        self.GroupName = dic[@"GroupName"];
        self.GroupStatic = dic[@"GroupStatic"];
        self.GroupTuiJian = dic[@"GroupTuiJian"];
        self.Id = dic[@"Id"];
        self.IserId = dic[@"IserId"];
        self.JoinNum = dic[@"JoinNum"];
        self.TypeName = dic[@"TypeName"];
        self.UserName = dic[@"UserName"];
        
        
    }
    return self;
}

@end
