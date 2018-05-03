//
//  GetBookTypeRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetBookTypeblcok)(NSDictionary *);
@interface GetBookTypeRequst : NSObject
-(void)GetBookTypeRequst :(GetBookTypeblcok)block;
@end
