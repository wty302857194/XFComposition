//
//  GetLabelTypeTreelistAllModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetLabelTypeTreelistAllModel.h"

@implementation GetLabelTypeTreelistAllModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.childfirst = dic[@"childfirst"];
        self.treeid = dic[@"id"];
        self.isParent = dic[@"isParent"];
        self.name = dic[@"name"];
        
    }
    return self;
}
@end
