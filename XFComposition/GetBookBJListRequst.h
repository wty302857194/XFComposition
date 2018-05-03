//
//  GetBookBJListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetBookBJListBlock)(NSDictionary *);
@interface GetBookBJListRequst : NSObject
-(void)GetBookBJListRequstWithbookid :(NSString *)bookid withremarktype :(NSString *)remarktype withistuijian :(NSString *)istuijian withremarkStatic :(NSString *)remarkStatic withkeyword :(NSString *)keyword withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withuserid :(NSString *)userid :(GetBookBJListBlock)block;
@end
