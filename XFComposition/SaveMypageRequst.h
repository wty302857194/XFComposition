//
//  SaveMypageRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/27.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SaveMypageBlock)(NSDictionary *);
@interface SaveMypageRequst : NSObject
-(void)SaveMypageRequstwithpagename :(NSString *)pagename withpagesocre :(NSString *)pagesocre withpageinfo :(NSString *)pageinfo withactiveid :(NSString *)activeid withpagetime :(NSString *)pagetime withsubjectids :(NSString *)subjectids withpageoksocer :(NSString *)pageoksocer withuserid :(NSString *)userid :(SaveMypageBlock)block;
@end
