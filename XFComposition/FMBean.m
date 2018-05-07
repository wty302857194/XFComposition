//
//  FMTableBean.m
//  FMLibrary
//
//  Created by leks on 13-4-18.
//  Copyright (c) 2013年 House365. All rights reserved.
//

#import "FMBean.h"

@implementation FMBean
@synthesize height = _height;
@synthesize rowIndex = _rowIndex;
@synthesize size = _size;

+(id)objectWithDictionary:(NSDictionary*)dictionary classType:(Class)classType
{
    if (![classType isSubclassOfClass:[FMBean class]]) {
        [NSException raise:@"FMBean初始化异常" format:@"%@非FMBean子类", classType];
        return nil;
    }
    
    if (![dictionary isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    
    id object = [[classType alloc] initWithDictionary:dictionary];
    
    return object;
}

+(NSMutableArray*)objectsWithArray:(NSArray*)array classType:(Class)classType
{
    if (![classType isSubclassOfClass:[FMBean class]])
    {
        [NSException raise:@"FMBean数组初始化异常" format:@"%@非FMBean子类", classType];
        return nil;
    }
    
    if (![array isKindOfClass:[NSArray class]])
    {
        return nil;
    }
    
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:10];
    for (int i=0; i<array.count; i++)
    {
        NSDictionary *dict = [array objectAtIndex:i];
        if ([dict isKindOfClass:[NSDictionary class]])
        {
            id object = [FMBean objectWithDictionary:dict classType:classType];
            if (object) {
                [ma addObject:object];
            }
        }
    }
    
    return ma;
}

+(id)objectForKey:(NSString*)key inDictionary:(NSDictionary*)dict withClass:(Class)objClass
{
    id result = nil;
    id obj = [dict objectForKey:key];
    if ([obj isKindOfClass:[NSDictionary class]])
    {
        result = [FMBean objectWithDictionary:obj classType:objClass];
    }
    return result;
}

+(NSMutableArray*)arrayForKey:(NSString*)key inDictionary:(NSDictionary*)dict withClass:(Class)objClass
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:10];
    id obj = [dict objectForKey:key];
    if ([obj isKindOfClass:[NSArray class]])
    {
        NSArray *array = obj;
        for (int i=0; i<array.count; i++)
        {
            NSDictionary *d = [array objectAtIndex:i];
            if ([d isKindOfClass:[NSDictionary class]])
            {
                id item = [FMBean objectWithDictionary:d classType:objClass];
                if (item) {
                    [result addObject:item];
                }
            }
        }
    }
    return result;
}

+(NSMutableArray*)dictionaryArrayByBeanArray:(NSArray*)beanArray
{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:10];
    for (int i=0; i<beanArray.count; i++)
    {
        FMBean *bean = [beanArray objectAtIndex:i];
        if ([bean isKindOfClass:[FMBean class]])
        {
            NSDictionary *dict = [bean dictionaryValue];
            if (dict)
            {
                [ma addObject:dict];
            }
        }
        else
        {
            [NSException raise:@"FMBean数组导出异常" format:@"%@非FMBean子类", [bean class]];
            return nil;
        }
    }
    
    return ma;
}

-(void)caculateHeight
{
	//subclass implement
}

-(id)initWithDictionary:(NSDictionary*)dictionary
{
    if (self = [super init]) {
        ;
    }
    
    return self;
}

-(NSDictionary*)dictionaryValue
{
    return nil;
}

@end
