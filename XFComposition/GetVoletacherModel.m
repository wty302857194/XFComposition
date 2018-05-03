
//
//  GetVoletacherModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetVoletacherModel.h"

@implementation GetVoletacherModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.teacherGyNum = dic[@"teacherGyNum"];
        self.teacherId = dic[@"teacherId"];
        self.teacherName = dic[@"teacherName"];
        self.teacherPic = dic[@"teacherPic"];
        self.teacherStartNum = dic[@"teacherStartNum"];
        self.teacherschool = dic[@"teacherschool"];
        self.teacherzc = dic[@"teacherzc"];
        
    }
    return self;
}

@end
