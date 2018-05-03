//
//  GetGroupUserRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetGroupUserBlock)(NSDictionary *);
@interface GetGroupUserRequst : NSObject
-(void)GetGroupUserRequstwithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withgroupId :(NSString *)groupId :(GetGroupUserBlock)block;
@end
