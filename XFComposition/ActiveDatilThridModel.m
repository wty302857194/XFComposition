//
//  ActiveDatilThridModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ActiveDatilThridModel.h"

@implementation ActiveDatilThridModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.allcount = dic[@"allcount"];
        self.childsecond = dic[@"childsecond"];
        self.thridid = dic[@"id"];
        self.isParent = dic[@"isParent"];
        self.name = dic[@"name"];
        self.rukucount = dic[@"rukucount"];
        
    }
    return self;
}
@end
