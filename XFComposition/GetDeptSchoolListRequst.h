//
//  GetDeptSchoolListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetDeptSchoolListblcok)(NSDictionary *);
@interface GetDeptSchoolListRequst : NSObject
-(void)GetDeptSchoolListRequstWithblock :(GetDeptSchoolListblcok)block;
@end
