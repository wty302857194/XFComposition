//
//  GetDajiaListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetDajiaListBlock)(NSDictionary *);
@interface GetDajiaListRequst : NSObject
-(void)GetDajiaListRequstwithClassid :(NSString *)Classid withdeptid :(NSString *)deptid withNewsType :(NSString *)NewsType withTags :(NSString *)Tags withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize :(GetDajiaListBlock)block;
@end
