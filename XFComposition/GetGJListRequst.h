//
//  GetGJListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetGJListBlock)(NSDictionary *);
@interface GetGJListRequst : NSObject
-(void)GetGJListRequstWithuserId :(NSString *)userId withPageIndex :(NSString *)pageindex withPagesize :(NSString *)pagesize withTypeid :(NSString *)typeId withModelid :(NSString *)modelid    :(GetGJListBlock)block;
@end
