//
//  MicroWriteModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicroWriteModel.h"

@implementation MicroWriteModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.content = dic[@"content"];
        self.userid = dic[@"userid"];
        self.username = dic[@"username"];
        self.writeid = dic[@"writeid"];
        self.writetitle = dic[@"writetitle"];
        
    }
    return self;
}

@end
