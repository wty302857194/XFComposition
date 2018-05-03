//
//  GetBookBjRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetBookBjblcok)(NSDictionary *);
@interface GetBookBjRequst : NSObject
-(void)GetBookBjRequstWithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withflag:(NSString *)flag withistuijian :(NSString *)istuijian :(GetBookBjblcok)block;
@end
