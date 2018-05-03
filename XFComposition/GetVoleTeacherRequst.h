//
//  GetVoleTeacherRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetVoleTeacherblock)(NSDictionary *);
@interface GetVoleTeacherRequst : NSObject
-(void)GetVoleTeacherRequstWithistuijian :(NSString *)istuijian withtop :(NSString *)top :(GetVoleTeacherblock)block;
@end
