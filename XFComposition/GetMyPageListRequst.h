//
//  GetMyPageListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetMyPageListBlock)(NSDictionary *);
@interface GetMyPageListRequst : NSObject
-(void)GetMyPageListRequstwithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withprivatpage :(NSString *)privatpage withuserid :(NSString *)userid :(GetMyPageListBlock)block;
@end
