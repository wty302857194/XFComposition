//
//  GetBookDongTaiRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetBookDongTaiblcok)(NSDictionary *);
@interface GetBookDongTaiRequst : NSObject
-(void)GetBookDongTaiRequst :(NSString *)bookid withflag :(NSString *)flag withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize :(GetBookDongTaiblcok)block;
@end
