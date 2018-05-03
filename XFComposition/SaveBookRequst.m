//
//  SaveBookRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/****
 保存图书
 ****/
#import "SaveBookRequst.h"
@interface SaveBookRequst()<AFNetworkRequestDatasource>

@end
@implementation SaveBookRequst
-(void)SaveBookRequstwithbookName :(NSString *)bookName withbookAuthor :(NSString *)bookAuthor withbookPublish :(NSString *)bookPublish withbookPic :(NSString *)bookPic withbookInfo :(NSString *)bookInfo withbookTypeID :(NSString *)bookTypeID withbookPages :(NSString *)bookPages withbookFlag :(NSString *)bookFlag withBookBuyAddress :(NSString *)BookBuyAddress withboobx :(NSString *)boobx withuserid :(NSString *)userid :(SaveBookblcok)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"SaveBook",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"bookName":bookName,
                                 @"bookAuthor":bookAuthor,
                                 @"bookPublish":bookPublish,
                                 @"bookPic":bookPic,
                                 @"bookInfo":bookInfo,
                                 @"bookTypeID":bookTypeID,
                                 @"bookPages":bookPages,
                                 @"bookFlag":bookFlag,
                                 @"BookBuyAddress":BookBuyAddress,
                                 @"boobx":boobx,
                                 @"userid":userid
                                 };
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        
        block(responseObject);
        NSLog(@"保存图书%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
