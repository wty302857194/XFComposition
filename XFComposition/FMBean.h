//
//  FMTableBean.h
//  FMLibrary
//
//  Created by leks on 13-4-18.
//  Copyright (c) 2013年 House365. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FMBEAN_DICT_ASSIGN_STRING(property_name, default_value)\
{\
id obj=[dictionary objectForKey:@#property_name];\
if([obj isKindOfClass:[NSString class]]) self.property_name = obj;\
else if([obj isKindOfClass:[NSNumber class]]) self.property_name = [NSString stringWithFormat:@"%@", obj];\
else self.property_name = default_value;\
}\

#define FMBEAN_DICT_KEY_ASSIGN_STRING(property_name, property_key, default_value)\
{\
id obj=[dict objectForKey:property_key];\
if([obj isKindOfClass:[NSString class]]) self.property_name = obj;\
else if([obj isKindOfClass:[NSNumber class]]) self.property_name = [NSString stringWithFormat:@"%@", obj];\
else self.property_name = default_value;\
}\

#define FMBEAN_DICT_ASSIGN_NUMBER(property_name, default_value)\
{\
id obj=[dictionary objectForKey:@#property_name];\
NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init]; \
if([obj isKindOfClass:[NSNumber class]]) self.property_name = obj;\
else self.property_name = [formatter numberFromString:default_value];\
}\

#define FMBEAN_DICT_ASSIGN_ARRAY_BASICTYPE(property_name)\
{\
self.property_name = [NSMutableArray arrayWithCapacity:10];\
id obj=[dictionary objectForKey:@#property_name];\
if([obj isKindOfClass:[NSArray class]]) \
{\
[self.property_name setArray:obj];\
}\
}\

#define FMBEAN_DICT_EXPORT_BASICTYPE(property_name)\
if(self.property_name) [md setObject:self.property_name forKey:@#property_name];

#define FMBEAN_DICT_EXPORT_ARRAY_BASICTYPE(property_name)\
{\
if ([self.property_name isKindOfClass:[NSArray class]])\
{\
[md setObject:self.property_name forKey:@#property_name];\
}\
}\


#define FMBEAN_DICT_EXPORT_BEAN(property_name)\
if([self.property_name respondsToSelector:@selector(dictionaryValue)])\
[md setObject:[self.property_name dictionaryValue] forKey:@#property_name];

#define FMBEAN_DICT_EXPORT_ARRAY_BEAN(property_name)\
{\
if ([self.property_name isKindOfClass:[NSArray class]])\
{\
NSMutableArray *ma = [NSMutableArray arrayWithCapacity:10];\
for (int i=0;i<[self.property_name count];i++)\
{\
id obj = [self.property_name objectAtIndex:i];\
if([obj respondsToSelector:@selector(dictionaryValue)]) [ma addObject:[obj dictionaryValue]];\
}\
[md setObject:ma forKey:@#property_name];\
}\
}

@interface FMBean : NSObject
{
    CGFloat _height;
    NSUInteger _rowIndex;
}

@property (nonatomic) CGFloat height;
@property (nonatomic) NSUInteger rowIndex;
@property (nonatomic) CGSize size;
@property (nonatomic) BOOL isSelected;


/*
 计算对应的FMTableCell高度
 */
-(void)caculateHeight;

/*
 通过dictionary初始化对象
 */
-(id)initWithDictionary:(NSDictionary*)dictionary;

/*
 将对象导出至字典
 */
-(NSDictionary*)dictionaryValue;

/*
 静态工具方法，通过dictionary初始化特定类对象，classType必须为FMBean子类
 */
+(id)objectWithDictionary:(NSDictionary*)dictionary classType:(Class)classType;

/*
 静态工具方法，通过dictionary初始化特定类对象数组，classType必须为FMBean子类
 */
+(NSMutableArray*)objectsWithArray:(NSArray*)array classType:(Class)classType;

/*
 静态工具方法，将对象导出至字典数组
 */
+(NSMutableArray*)dictionaryArrayByBeanArray:(NSArray*)beanArray;

/*
 静态工具方法，通过dictionary和key初始化特定类对象，classType必须为FMBean子类
 该方法取[dict objectForKey:key]来初始化对象
 */
+(id)objectForKey:(NSString*)key inDictionary:(NSDictionary*)dict withClass:(Class)objClass;

/*
 静态工具方法，通过dictionary和key初始化特定类对象数组，classType必须为FMBean子类
 该方法取[dict objectForKey:key]来初始化对象
 */
+(NSMutableArray*)arrayForKey:(NSString*)key inDictionary:(NSDictionary*)dict withClass:(Class)objClass;
@end
