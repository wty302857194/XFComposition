//
//  WriteListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/5.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "WriteListModel.h"

@implementation WriteListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.ID = dic[@"ID"];
        self.MicroclassInfoAbstract = dic[@"MicroclassInfoAbstract"];
        self.MicroclassInfoAddTime = dic[@"MicroclassInfoAddTime"];
        self.MicroclassInfoAttr = dic[@"MicroclassInfoAttr"];
        self.MicroclassInfoAttr1 = dic[@"MicroclassInfoAttr1"];
        self.MicroclassInfoEndTime = dic[@"MicroclassInfoEndTime"];
        self.MicroclassInfoIsRecommend = dic[@"MicroclassInfoIsRecommend"];
        self.MicroclassInfoMaster = dic[@"MicroclassInfoMaster"];
        self.MicroclassInfoObject = dic[@"MicroclassInfoObject"];
        self.MicroclassInfoStartTime = dic[@"MicroclassInfoStartTime"];
        self.MicroclassInfoStatic = dic[@"MicroclassInfoStatic"];
        self.MicroclassInfoTarget = dic[@"MicroclassInfoTarget"];
        self.MicroclassInfoTitle = dic[@"MicroclassInfoTitle"];
        self.VideoNum = dic[@"VideoNum"];
        
        
    }
    return self;
}

@end
