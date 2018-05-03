//
//  GetTeachNeedCheckListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetTeachNeedCheckListBlock)(NSDictionary *);
@interface GetTeachNeedCheckListRequst : NSObject
-(void)GetTeachNeedCheckListRequstWithuserId :(NSString *)userId withactiveId :(NSString *)activeId withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withcheckType :(NSString *)checkType withworkName :(NSString *)workName :(GetTeachNeedCheckListBlock)block;
@end
