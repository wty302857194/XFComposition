//
//  XFLibrary.m
//  XFComposition
//
//  Created by qiannian on 2018/5/16.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "XFLibrary.h"

@implementation XFLibrary
-(id)initWithDictionary:(NSDictionary*)dict
{
    
    if (self = [super init])
    {
        DTAPI_DICT_ASSIGN_STRING(ID, @"");
        DTAPI_DICT_ASSIGN_STRING(PicID, @"");
        DTAPI_DICT_ASSIGN_STRING(UserID, @"");
        DTAPI_DICT_ASSIGN_STRING(BlogID, @"");
        DTAPI_DICT_ASSIGN_STRING(ExtractType, @"");
        DTAPI_DICT_ASSIGN_STRING(ExtractPicUrl, @"");
        DTAPI_DICT_ASSIGN_STRING(ExtractContent, @"");
        DTAPI_DICT_ASSIGN_STRING(CreateTime, @"");
        
    }
    
    return self;
    
}
@end
