//
//  IsVoleTeacherRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/19.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^IsVoleTeacherblock)(NSDictionary *);
@interface IsVoleTeacherRequst : NSObject
-(void)IsVoleTeacherRequstWithuserid :(NSString *)userid :(IsVoleTeacherblock)block;
@end
