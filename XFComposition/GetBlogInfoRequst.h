//
//  GetBlogInfoRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetBlogInfoBlock)(NSDictionary *);
@interface GetBlogInfoRequst : NSObject

-(void)GetBlogInfoRequstWithblogid :(NSString *)blogid :(GetBlogInfoBlock)block;
@end
