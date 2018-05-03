//
//  GetHjListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetHjListblock)(NSDictionary *);
@interface GetHjListRequst : NSObject

-(void)GetHjListRequstWithblogid :(NSString *)blogid  pageindex:(NSString *)index  pagesize:(NSString *)size  :(GetHjListblock)block;
@end
