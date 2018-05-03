//
//  GetBookPaihangModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetBookPaihangModel.h"

@implementation GetBookPaihangModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.bookname = dic[@"bookname"];
        self.bookpaihangid = dic[@"id"];
        self.readnum = dic[@"readnum"];
        
    }
    return self;
}

@end
