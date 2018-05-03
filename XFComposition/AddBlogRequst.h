//
//  AddBlogRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/29.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^AddBlogBlock)(NSDictionary *);
@interface AddBlogRequst : NSObject
-(void)AddBlogRequstWithNoticeName: (NSString *)noticeName withNoticeObject :(NSString *)noticeObject withNoticeContent :(NSString *)noticeContent withNoticeID :(NSString *)noticeID withuserid :(NSString *)userid withactiveItemId :(NSString *)activeItemId withposttype :(NSString *)posttype :(AddBlogBlock)block;
@end
