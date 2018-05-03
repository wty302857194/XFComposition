//
//  TeachApplyActionRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TeachApplyAction)(NSDictionary *);
@interface TeachApplyActionRequst : NSObject
-(void)TeachApplyActionWithUserId :(NSString *)userId withName :(NSString *)name withAge :(NSString *)age withSex :(NSString *)sex withPhone :(NSString *)phone withteacherpic :(NSString *)teacherpic withteachercardfond :(NSString *)teachercardfond withteachercardback :(NSString *)teachercardback withteachercertified :(NSString *)teachercertified withteacherworkcard :(NSString *)teacherworkcard withteacherapplytable1 :(NSString *)teacherapplytable1 withteacherapplytable2 :(NSString *)teacherapplytable2 withteacherinfo :(NSString *)teacherinfo :(TeachApplyAction)block;
@end
