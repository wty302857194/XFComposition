//
//  GetBookBjInfoRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetBookBjInfoblcok)(NSDictionary *);
@interface GetBookBjInfoRequst : NSObject
-(void)GetBookBjInfoRequstWithbjid :(NSString *)bjid :(GetBookBjInfoblcok)block;
@end
