//
//  GetMessageListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/24.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetMessageListModel.h"

@implementation GetMessageListModel

-(id)initWithDictionary:(NSDictionary*)dict
{
    
    if (self = [super init])
    {
        DTAPI_DICT_ASSIGN_STRING(DateTime, @"");
        DTAPI_DICT_ASSIGN_STRING(ID, @"");
        DTAPI_DICT_ASSIGN_STRING(MesType, @"");
        DTAPI_DICT_ASSIGN_STRING(ReadFlag, @"");
        DTAPI_DICT_ASSIGN_STRING(Title, @"");
    }
   
    return self;
    
}
@end
