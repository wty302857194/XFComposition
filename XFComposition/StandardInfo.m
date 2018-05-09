//
//  StandardInfo.m
//  XFComposition
//
//  Created by qiannian on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "StandardInfo.h"

@implementation StandardInfo
-(id)initWithDictionary:(NSDictionary*)dict
{
    
    if (self = [super init])
    {
        DTAPI_DICT_ASSIGN_STRING(StandardId, @"");
        DTAPI_DICT_ASSIGN_STRING(StandardText, @"");
        DTAPI_DICT_ASSIGN_STRING(ModelId, @"");
        DTAPI_DICT_ASSIGN_STRING(Status, @"");
        DTAPI_DICT_ASSIGN_STRING(AddUser, @"");
        DTAPI_DICT_ASSIGN_STRING(AddTime, @"");
        DTAPI_DICT_ASSIGN_STRING(IsSystem, @"");
        DTAPI_DICT_ASSIGN_STRING(ObjectId, @"");
    }
    
    return self;
    
}@end
