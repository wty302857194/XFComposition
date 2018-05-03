//
//  SaveBookRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SaveBookblcok)(NSDictionary *);
@interface SaveBookRequst : NSObject
-(void)SaveBookRequstwithbookName :(NSString *)bookName withbookAuthor :(NSString *)bookAuthor withbookPublish :(NSString *)bookPublish withbookPic :(NSString *)bookPic withbookInfo :(NSString *)bookInfo withbookTypeID :(NSString *)bookTypeID withbookPages :(NSString *)bookPages withbookFlag :(NSString *)bookFlag withBookBuyAddress :(NSString *)BookBuyAddress withboobx :(NSString *)boobx withuserid :(NSString *)userid :(SaveBookblcok)block;
@end
