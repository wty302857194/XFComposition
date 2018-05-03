//
//  GetPageSubjectRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/30.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetPageSubjectResultBlock)(NSDictionary *);
@interface GetPageSubjectRequst : NSObject
-(void)GetPageSubjectRequstwithpageid :(NSString *)pageid  withuserid :(NSString *)userid :(GetPageSubjectResultBlock)block;
-(void)GetBookSubjectRequstwithpageid :(NSString *)bookid :(GetPageSubjectResultBlock)block;
-(void)PostAnswerRequstwithpageid :(NSString *)bookid  withuserid :(NSString *)userid  daan:(NSString *)daan :(GetPageSubjectResultBlock)block;
@end
