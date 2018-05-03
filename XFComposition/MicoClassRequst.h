//
//  MicoClassRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^micClassblcok)(NSDictionary *);
@interface MicoClassRequst : NSObject
-(void)requstGetmicListWithchangId:(NSString *)changId Withmasterid:(NSString *)masterid Withsubjectid:(NSString *)subjectid Withindex:(NSString *)pageindex Withpagesize:(NSString *)pasize Withrecommed:(NSString *)recommed Withprostatic:(NSString *)protatic Withtimespan:(NSString *)timespan :(micClassblcok)block;
@end
