//
//  GetPageListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetPageListBlock)(NSDictionary *);
@interface GetPageListRequst : NSObject
-(void)GetPageListRequstwithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withchaperid :(NSString *)chaperid withkeyword :(NSString *)keyword withscheckype :(NSString *)scheckype withuserid :(NSString *)userid :(GetPageListBlock)block;
@end
