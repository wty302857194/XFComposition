//
//  TeacherApplyVolRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TeacherApplyVolBlock)(NSDictionary *);
@interface TeacherApplyVolRequst : NSObject
-(void)TeacherApplyVolRequstWithuserid:(NSString *)userid withWriteNum :(NSString *)WriteNum withActiveId :(NSString *)ActiveId withfirstSet :(NSString *)firstSet withjinji :(NSString *)jinji withfreeTime: (NSString *)freeTime :(TeacherApplyVolBlock)block;
@end
