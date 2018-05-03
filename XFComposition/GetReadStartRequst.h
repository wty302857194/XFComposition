//
//  GetReadStartRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetReadStartblcok)(NSDictionary *);
@interface GetReadStartRequst : NSObject
-(void)GetReadStartRequstwithflag :(NSString *)flag withnum :(NSString *)num :(GetReadStartblcok)block;
@end
