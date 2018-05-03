//
//  ActivityDetailRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ActivityDetailRequstBlock)(NSDictionary *);
@interface ActivityDetailRequst : NSObject
-(void)ActivityDetailwithActiveID:(NSString *)type :(ActivityDetailRequstBlock)block;
@end
