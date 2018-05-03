//
//  GetMessageWaitNumRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetMessageWaitNumBlock)(NSDictionary *);
@interface GetMessageWaitNumRequst : NSObject
-(void)GetMessageWaitNumRequstWithuserid :(NSString *)userid :(GetMessageWaitNumBlock)block;
@end
