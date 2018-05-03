//
//  GetMybookListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetMybookListBlock)(NSDictionary *);
@interface GetMybookListRequst : NSObject
-(void)GetMybookListRequstWithchaperid :(NSString *)chaperid withbooktype :(NSString *)booktype withbookgrade :(NSString *)bookgrade withkeyword :(NSString *)keyword withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withuserid :(NSString *)userid :(GetMybookListBlock)block;
@end
