//
//  GetReadStartModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetReadStartModel.h"

@implementation GetReadStartModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.conname = dic[@"conname"];
        self.readpaihangid = dic[@"id"];
        self.num = dic[@"num"];
        
    }
    return self;
}

@end
