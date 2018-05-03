//
//  GetMyPageSubjectListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/18.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetMyPageSubjectListModel.h"

@implementation GetMyPageSubjectListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.SubjectAddTime = dic[@"SubjectAddTime"];
        self.SubjectID = dic[@"SubjectID"];
        self.SubjectSocre = dic[@"SubjectSocre"];
        self.SubjectStatic = dic[@"SubjectStatic"];
        self.SubjectTitle = dic[@"SubjectTitle"];
        self.SubjectType = [dic[@"SubjectType"] integerValue];
        
    }
    return self;
}

@end
