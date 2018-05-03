//
//  WeikePostCommentRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/9.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^WeikePostCommentBlock)(NSDictionary *);
@interface WeikePostCommentRequst : NSObject
-(void)WeikePostCommentRequstwithuserid :(NSString *)userid withmodelid :(NSString *)modelid withclassid :(NSString *)classid withuserip :(NSString *)userip withCommentinfo :(NSString *)Commentinfo :(WeikePostCommentBlock)block;
@end
