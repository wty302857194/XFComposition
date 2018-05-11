//
//  GetWritePicModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetWritePicModel.h"

@implementation GetWritePicModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithDictionary:json];
    
}
-(id)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [super init])
    {
        DTAPI_DICT_ASSIGN_STRING(BlogID, @"");
        DTAPI_DICT_ASSIGN_STRING(CreateTime, @"");
        DTAPI_DICT_ASSIGN_STRING(ID, @"");
        DTAPI_DICT_ASSIGN_STRING(PicID, @"");
        DTAPI_DICT_ASSIGN_STRING(PicUrl, @"");
        DTAPI_DICT_ASSIGN_STRING(FixPicUrl, @"");
        DTAPI_DICT_ASSIGN_STRING(Sort, @"");
        DTAPI_DICT_ASSIGN_STRING(CheckUserID, @"");
        DTAPI_DICT_ASSIGN_STRING(UserID, @"");
        
    }
    
    return self;
    
}

@end
