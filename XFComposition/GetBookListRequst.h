//
//  GetBookListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetBookListblcok)(NSDictionary *);
@interface GetBookListRequst : NSObject
-(void)GetBookListRequstWithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withchaperid :(NSString *)chaperid withauthor :(NSString *)author withkeyword :(NSString *)keyword withbooktype :(NSString *)booktype withisdaodu :(NSString *)isdaodu withistuijian :(NSString *)istuijian withishost :(NSString *)ishost withquxian :(NSString *)quxian withxuexiao :(NSString *)xuexiao :(GetBookListblcok)block;
@end
