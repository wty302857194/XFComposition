//
//  GetReadActiveRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetReadActiveBlock)(NSDictionary *);
@interface GetReadActiveRequst : NSObject
-(void)GetReadActiveRequstwithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withkeyword :(NSString *)keyword withActiveTypeID :(NSString *)ActiveTypeID :(GetReadActiveBlock)block;
@end
