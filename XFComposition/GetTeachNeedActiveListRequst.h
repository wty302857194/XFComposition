//
//  GetTeachNeedActiveListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetTeachNeedActiveListBlock)(NSDictionary *);
@interface GetTeachNeedActiveListRequst : NSObject
-(void)GetTeachNeedActiveListRequstWithuserId :(NSString *)userId withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withkeyWord :(NSString *)keyWord :(GetTeachNeedActiveListBlock)block;
@end
