//
//  AddBlogwritingRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^AddBlogwritingBlock)(NSDictionary *);
@interface AddBlogwritingRequst : NSObject
-(void)AddBlogwritingRequstwithNoticeName :(NSString *)NoticeName withNoticeObject :(NSString *)NoticeObject withNoticeContent :(NSString *)NoticeContent withNoticeID :(NSString *)NoticeID withuserid :(NSString *)userid withmodel :(NSString *)model withposttype :(NSString *)posttype withIsApp :(NSString *)IsApp :(AddBlogwritingBlock)block;
@end
