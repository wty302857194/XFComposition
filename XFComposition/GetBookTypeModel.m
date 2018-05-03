//
//  GetBookTypeModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetBookTypeModel.h"

@implementation GetBookTypeModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.BookTypeName = dic[@"BookTypeName"];
        self.Itemlist = dic[@"Itemlist"];
        self.BookTypeid = dic[@"id"];
    }
    return self;
}
@end
