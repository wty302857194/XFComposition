//
//  GetDinaPinListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetDinaPinListblock)(NSDictionary *);
@interface GetDinaPinListRequst : NSObject
-(void)GetDinaPinListRequswithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withclassId :(NSString *)classId withmodelId :(NSString *)modelId withkeyWord :(NSString *)keyWord :(GetDinaPinListblock)block;
@end
