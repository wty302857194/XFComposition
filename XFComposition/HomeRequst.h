//
//  HomeRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/4.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^requstBlock)(NSDictionary *);
@interface HomeRequst : NSObject
-(void)HomeRequsetGetList :(requstBlock)block;
@end
