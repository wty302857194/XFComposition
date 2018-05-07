//
//  MessageDetail.m
//  XFComposition
//
//  Created by qiannian on 2018/5/4.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "MessageDetail.h"

@implementation MessageDetail
-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self = [super init])
    {
        DTAPI_DICT_ASSIGN_STRING(HSUSERID, @"");
        DTAPI_DICT_ASSIGN_STRING(UserId, @"");
        DTAPI_DICT_ASSIGN_STRING(UserName, @"");
        DTAPI_DICT_ASSIGN_STRING(RepostTime, @"");
        DTAPI_DICT_ASSIGN_STRING(RepostUserID, @"");
        DTAPI_DICT_ASSIGN_STRING(Metitle, @"");
        DTAPI_DICT_ASSIGN_STRING(Mecontain, @"");
        DTAPI_DICT_ASSIGN_STRING(SendUserID, @"");
        DTAPI_DICT_ASSIGN_STRING(SendUserName, @"");
       
    }
    
    return self;
}
@end
