//
//  MyWritingDetailModel.m
//  XFComposition
//
//  Created by chenshunyi on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "MyWritingDetailModel.h"

@implementation MyWritingDetailModel


-(instancetype)initWithDic:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end
