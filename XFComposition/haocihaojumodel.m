//
//  haocihaojumodel.m
//  XFComposition
//
//  Created by longrise on 2018/3/24.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "haocihaojumodel.h"

@implementation haocihaojumodel

+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.info = dic[@"info"];
        self.byusername = dic[@"byusername"];
        self.commentinfo = dic[@"commentinfo"];
        self.blogid = dic[@"blogid"];
        self.addtime = dic[@"addtime"];
     
        
        
    }
    return self;
}

@end
