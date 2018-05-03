//
//  GetStaticBookBjRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetStaticBookBjblcok)(NSDictionary *);
@interface GetStaticBookBjRequst : NSObject
-(void)GetStaticBookBjRequstWithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withflag :(NSString *)flag withistuijian :(NSString *)istuijian :(GetStaticBookBjblcok)block;
@end
