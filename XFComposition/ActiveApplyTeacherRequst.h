//
//  ActiveApplyTeacherRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetActiveApplyTeacherList)(NSDictionary *);
@interface ActiveApplyTeacherRequst : NSObject
-(void)GetActiveApplyTeacherListWithPageIndex :(NSString *)index withPagesize :(NSString *)pagesize withactiveID :(NSString *)activeId withteacherstatic :(NSInteger)teacherstatic :(GetActiveApplyTeacherList)block;

@end
