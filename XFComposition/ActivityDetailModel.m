//
//  ActivityDetailModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ActivityDetailModel.h"

@implementation ActivityDetailModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.activeID = dic[@"activeID"];
        self.IsChooseTeacher = dic[@"IsChooseTeacher"];
        self.activeEndTime = dic[@"activeEndTime"];
        self.activeInfo = dic[@"activeInfo"];
        self.activeLimite = dic[@"activeLimite"];
        self.activeMin = dic[@"activeMin"];
        self.activeName = dic[@"activeName"];
        self.activeNum = dic[@"activeNum"];
        self.activePic = dic[@"activePic"];
        self.activeStartTime = dic[@"activeStartTime"];
        self.activeType = dic[@"activeType"];
        
    }
    return self;
}

@end
