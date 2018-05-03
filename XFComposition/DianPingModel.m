//
//  DianPingModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/5.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "DianPingModel.h"

@implementation DianPingModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.activename = dic[@"activename"];
        self.checkname = dic[@"checkname"];
        self.checktime = dic[@"checktime"];
        self.grade = dic[@"grade"];
        self.DPid = dic[@"id"];
        self.title = dic[@"title"];
        self.username = dic[@"username"];
        
    }
    return self;
}

@end
