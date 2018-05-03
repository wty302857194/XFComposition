//
//  GetTeachNeedCheckListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetTeachNeedCheckListModel.h"

@implementation GetTeachNeedCheckListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.ID = dic[@"ID"];
        self.IsCheck = dic[@"IsCheck"];
        self.Isback = dic[@"Isback"];
        self.ScoreInfo = dic[@"ScoreInfo"];
        self.WorkId = dic[@"WorkId"];
        self.WorkName = dic[@"WorkName"];
        
    }
    return self;
}

@end
