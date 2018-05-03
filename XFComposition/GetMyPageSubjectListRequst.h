//
//  GetMyPageSubjectListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/18.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetMyPageSubjectListBlock)(NSDictionary *);
@interface GetMyPageSubjectListRequst : NSObject
-(void)GetMyPageSubjectListRequstwithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withchaperid :(NSString *)chaperid withkeyword :(NSString *)keyword withscheckype :(NSString *)scheckype withActiveid :(NSString *)Activeid withuserid :(NSString *)userid :(GetMyPageSubjectListBlock)block;
@end
