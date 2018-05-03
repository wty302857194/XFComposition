//
//  MicroAddcommentRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetMricoAddpianduanrequst)(NSDictionary *);
@interface MicroAddcommentRequst : NSObject
-(void)GetMricoAddpianduanrequsWithNoticeName :(NSString *)name withNoticeObject:(NSString *)noticeObject withNoticeContment:(NSString *)NoticeContent withNoticeId :(NSString *)NoticeID withUserId:(NSString *)userid :(GetMricoAddpianduanrequst)block;
@end
