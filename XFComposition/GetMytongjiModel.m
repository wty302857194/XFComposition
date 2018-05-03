//
//  GetMytongjiModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetMytongjiModel.h"

@implementation GetMytongjiModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.checknum = [dic[@"checknum"] integerValue];
        self.successnum = [dic[@"successnum"] integerValue];
        self.todaynum = [dic[@"todaynum"] integerValue];
        
        
    }
    return self;
}

@end
