//
//  GetPageListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetPageListModel.h"

@implementation GetPageListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.Attribute1 = dic[@"Attribute1"];
        self.Attribute2 = dic[@"Attribute2"];
        self.TestTempID = dic[@"TestTempID"];
        self.addtime = dic[@"addtime"];
        self.allsocre = dic[@"allsocre"];
        self.oksocre = dic[@"oksocre"];
        self.pageid = dic[@"pageid"];
        self.testOkSocre = dic[@"testOkSocre"];
        
    }
    return self;
}

@end
