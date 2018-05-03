//
//  GetGroupTypeModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetGroupTypeModel.h"

@implementation GetGroupTypeModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.Typeid = [dic[@"id"] integerValue];
        self.name = dic[@"name"];
        
    }
    return self;
}

@end
