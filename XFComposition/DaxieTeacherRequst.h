//
//  DaxieTeacherRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^DaxieTeacherBlock)(NSDictionary *);
@interface DaxieTeacherRequst : NSObject
-(void)DaxieTeacherRequstWithuserId :(NSString *)userId withworkId :(NSString *)workId :(DaxieTeacherBlock)block;
@end
