//
//  DelBookBJRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^DelBookBJBlock)(NSDictionary *);
@interface DelBookBJRequst : NSObject
-(void)DelBookBJRequstWithids :(NSString *)ids withFlag :(NSString *)Flag withuserid :(NSString *)userid :(DelBookBJBlock)block;
@end
