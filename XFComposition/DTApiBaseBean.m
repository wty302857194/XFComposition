//
//  DTApiBaseBean.m
//  DTApi
//
//  Created by leks on 13-2-18.
//  Copyright (c) 2013年 leks. All rights reserved.
//

#import "DTApiBaseBean.h"

@implementation DTApiBaseBean

+(id)objectForKey:(NSString*)key inDictionary:(NSDictionary*)dict withClass:(Class)objClass
{
    id result = nil;
    id obj = [dict objectForKey:key];
    if ([obj isKindOfClass:[NSDictionary class]])
    {
        result =[[objClass alloc] initWithDictionary:obj] ;
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
                id item =[[objClass alloc] initWithDictionary:d] ;
                if (item) {
                    [result addObject:item];
                }
            }
        }
    }
    return result;
}
@end
