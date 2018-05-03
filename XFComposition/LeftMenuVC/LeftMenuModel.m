//
//  LeftMenuModel.m
//  XFComposition
//
//  Created by wbb on 2018/4/19.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "LeftMenuModel.h"

@implementation LeftMenuModel
+ (NSDictionary *)objectClassInArray{
    return @{@"childfirst" : [LeftMenuSecondModel class]};
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"userid": @"id"};
}
@end

@implementation LeftMenuSecondModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"userid": @"id"};
}
@end
