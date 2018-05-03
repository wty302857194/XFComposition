//
//  GetMessageListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/24.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetMessageListBlock)(NSDictionary *);
@interface GetMessageListRequst : NSObject
-(void)GetMessageListRequstwithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withtype :(NSString *)type withflag :(NSString *)flag withuserid :(NSString *)userid :(GetMessageListBlock)block;
@end
