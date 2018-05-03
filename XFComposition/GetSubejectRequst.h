//
//  GetSubejectRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetSubejectblcok)(NSDictionary *);
@interface GetSubejectRequst : NSObject
-(void)GetSubejectRequstwithbookid :(NSString *)bookid :(GetSubejectblcok)block;
@end
