//
//  HomeBookRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/4.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetBookListRequst)(NSDictionary *);
@interface HomeBookRequst : NSObject
-(void)HomeGetBookListWithchaperid :(NSString*)istuijian :(NSString *)pagesize :(NSString *)isHost :(NSString *)quxian :(NSString *)student :(NSString *)teacher :(GetBookListRequst)block;
@end
