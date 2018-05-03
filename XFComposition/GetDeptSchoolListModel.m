//
//  GetDeptSchoolListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetDeptSchoolListModel.h"

@implementation GetDeptSchoolListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.deptid = dic[@"deptid"];
        self.deptname = dic[@"deptname"];
        
    }
    return self;
}

@end
