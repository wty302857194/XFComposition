//
//  MicroClassGradeModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicroClassGradeModel.h"

@implementation MicroClassGradeModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.gid = dic[@"gid"];
        self.gradename = dic[@"gradename"];
        
    }
    return self;
}

@end
