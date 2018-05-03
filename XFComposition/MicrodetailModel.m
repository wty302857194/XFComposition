//
//  MicrodetailModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicrodetailModel.h"

@implementation MicrodetailModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.classEndTime = dic[@"classEndTime"];
        
        self.classFavTime= dic[@"classFavTime"] ;
        self.classInfo = dic[@"classInfo"];
        self.classJoinTime = dic[@"classJoinTime"];
        self.classKeyWord = dic[@"classKeyWord"];
        self.classMarket = dic[@"classMarket"];
        self.classMaster = dic[@"classMaster"];
        self.classMasterId = dic[@"classMasterId"];
        self.className =dic[@"className"];
        self.classObject = dic[@"classObject"];
        self.classOrderId = dic[@"classOrderId"];
        self.classPicPath = dic[@"classPicPath"];
        
        self.classRootId = dic[@"classRootId"];
        self.classShareTime =dic[@"classShareTime"];
        self.classStartTime = dic[@"classStartTime"];
        self.classStatic = dic[@"classStatic"];
        self.classSubjectId = dic[@"classSubjectId"];
        self.classTarget = dic[@"classTarget"];
        self.classViewTime =dic[@"classViewTime"];
        self.reCommend = dic[@"reCommend"];
        
        self.videoList = dic[@"videoList"];
        self.writelist = dic[@"writelist"];
    }
    return self;
}

@end
