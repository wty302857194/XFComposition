//
//  getBookSubjectResultRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^getBookSubjectResultBlock)(NSDictionary *);
@interface getBookSubjectResultRequst : NSObject
-(void)getBookSubjectResultRequstwithbookid :(NSString *)bookid withuserid :(NSString *)userid :(getBookSubjectResultBlock)block;
@end
