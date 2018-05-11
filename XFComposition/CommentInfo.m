//
//  CommentInfo.m
//  XFComposition
//
//  Created by qiannian on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "CommentInfo.h"

@implementation CommentInfo
-(id)initWithDictionary:(NSDictionary*)dict
{
    
    if (self = [super init])
    {
        DTAPI_DICT_ASSIGN_STRING(ID, @"");
        DTAPI_DICT_ASSIGN_STRING(CommentsInfo, @"");
        DTAPI_DICT_ASSIGN_STRING(UserID, @"");
        DTAPI_DICT_ASSIGN_STRING(UserType, @"");
        DTAPI_DICT_ASSIGN_STRING(Addtime, @"");
        DTAPI_DICT_ASSIGN_STRING(CommentsScore, @"");
        DTAPI_DICT_ASSIGN_STRING(CommentsStatic, @"");
        DTAPI_DICT_ASSIGN_STRING(CommentsAttribute1, @"");
        DTAPI_DICT_ASSIGN_STRING(CommentsAttribute2, @"");
     
    }
    
    return self;
    
}
@end
