//
//  MicroClassTypeModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicroClassTypeModel.h"

@implementation MicroClassTypeModel
//+(id)loadWithJSOn:(NSDictionary *)json{
//    return [[self alloc]initWithJSON:json];
//
//}
//-(id)initWithJSON:(NSDictionary *)dic{
//    if (self = [super init]) {
//        self.childgrade = dic[@"childgrade"];
//        self.tizainame = dic[@"tizainame"];
//        self.zaitiid = dic[@"zaitiid"];
//
//    }
//    return self;
//}
+ (NSDictionary *)objectClassInArray{
    return @{@"childgrade" : [ChildgradeModel class]};
}
@end

@implementation ChildgradeModel
@end
