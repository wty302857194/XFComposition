//
//  GetActiveApplyTeacherModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetActiveApplyTeacherModel.h"

@implementation GetActiveApplyTeacherModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.activeid = dic[@"activeid"];
        self.jinji = dic[@"jinji"];
        self.teacherStartNum = dic[@"teacherStartNum"];
        self.teacherclassfirst = dic[@"teacherclassfirst"];
        self.teacherfreetime = dic[@"teacherfreetime"];
        self.teacherid = dic[@"teacherid"];
        self.teacherischeck = dic[@"teacherischeck"];
        self.teachermaxnum = dic[@"teachermaxnum"];
        self.teachername = dic[@"teachername"];
        self.teacherphone = dic[@"teacherphone"];
        self.teacherpic = dic[@"teacherpic"];
        self.teacherschool = dic[@"teacherschool"];
    }
    return self;
}

@end
