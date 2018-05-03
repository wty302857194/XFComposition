//
//  GetMygroupListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetMygroupListModel.h"

@implementation GetMygroupListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        
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
