//
//  MicroPianduanRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetMricopianduanrequst)(NSDictionary *);
@interface MicroPianduanRequst : NSObject
-(void)GetMricopianduanwithNoticeObject:(NSString *)noticeObject withmodelid :(NSString *)modelid withUserId:(NSString *)userid : (NSString*)pageindex :(NSString *)pagesize :(GetMricopianduanrequst)block;
@end
