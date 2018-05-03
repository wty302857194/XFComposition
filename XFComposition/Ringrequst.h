//
//  Ringrequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ringReqsut)(NSDictionary *);
@interface Ringrequst : NSObject
-(void)GetRingList :(NSInteger)page :(ringReqsut)block;
@end
