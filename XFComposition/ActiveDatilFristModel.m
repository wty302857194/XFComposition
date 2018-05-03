//
//  ActiveDatilFristModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ActiveDatilFristModel.h"

@implementation ActiveDatilFristModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.ID = dic[@"ID"];
        self.IsChooseTeacher = dic[@"IsChooseTeacher"];
        self.activeEndTime = dic[@"activeEndTime"];
        self.activeInfo = dic[@"activeInfo"];
        self.ID = dic[@"ID"];
        self.activeLimite = dic[@"activeLimite"];
        self.activeMin = dic[@"activeMin"];
        self.activeName = dic[@"activeName"];
        self.activeNav = dic[@"activeNav"];
        
        self.activeNum = dic[@"activeNum"];
        self.activePic = dic[@"activePic"];
        self.activeStartTime = dic[@"activeStartTime"];
        self.activeType = dic[@"activeType"];
        
    }
    return self;
}
@end
