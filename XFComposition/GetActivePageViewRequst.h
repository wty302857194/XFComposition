//
//  GetActivePageViewRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetActivePageViewBlock)(NSDictionary *);
@interface GetActivePageViewRequst : NSObject
-(void)GetActivePageViewRequstwithSubjectid :(NSString *)Subjectid :(GetActivePageViewBlock)block;
@end
