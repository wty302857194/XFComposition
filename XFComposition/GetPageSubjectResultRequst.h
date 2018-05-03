//
//  GetPageSubjectResultRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/27.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetPageSubjectResultBlock)(NSDictionary *);
@interface GetPageSubjectResultRequst : NSObject
-(void)GetPageSubjectResultRequstwithpageid :(NSString *)pageid withuserid :(NSString *)userid :(GetPageSubjectResultBlock)block;
@end
