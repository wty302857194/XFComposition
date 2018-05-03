//
//  GetBlogContentInfoRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetBlogContentInfoBlock)(NSDictionary *);
@interface GetBlogContentInfoRequst : NSObject
-(void)GetBlogContentInfoRequstWithNoticeID: (NSString *)NoticeID :(GetBlogContentInfoBlock)block;

@end
