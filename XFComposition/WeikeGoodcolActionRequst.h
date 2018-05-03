//
//  WeikeGoodcolActionRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/9.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^WeikeGoodcolActionBlock)(NSDictionary *);
@interface WeikeGoodcolActionRequst : NSObject
-(void)WeikeGoodcolActionRequstwith :(NSString *)userid withweikeid :(NSString *)weikeid withtypeflag :(NSString *)typeflag :(WeikeGoodcolActionBlock)block;
@end
