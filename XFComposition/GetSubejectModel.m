//
//  GetSubejectModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetSubejectModel.h"

@implementation GetSubejectModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.joinnum = dic[@"joinnum"];
        self.subjectnum = dic[@"subjectnum"];
        
    }
    return self;
}

@end
