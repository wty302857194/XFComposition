//
//  DeleteBlogRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^DeleteBlogtBlock)(NSDictionary *);
@interface DeleteBlogRequst : NSObject
-(void)DeleteBlogRequstWithNoticeIds :(NSString *)NoticeIds withUserid :(NSString *)Userid withFlag :(NSString *)Flag :(DeleteBlogtBlock)block;
@end
