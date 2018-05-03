//
//  GetActiveApplyTeacherList.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetActiveApplyTeacherListrequst)(NSDictionary *);
@interface GetActiveApplyTeacherList : NSObject
-(void)GetActiveApplyTeacherListWithPageIndex :(NSInteger)pageindex withPageSize :(NSInteger)PageSize withactiveid :(NSString *)activeid withteacherstatic :(NSString *)teacherstatic :(GetActiveApplyTeacherListrequst)block;
@end
