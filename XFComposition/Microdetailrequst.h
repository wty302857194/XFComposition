//
//  Microdetailrequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetmicrodetailInfo)(NSDictionary *);
@interface Microdetailrequst : NSObject
-(void)GetmicroInfoWithClassId :(NSString *)classId withUserId:(NSString *)userId :(GetmicrodetailInfo)block;
@end
