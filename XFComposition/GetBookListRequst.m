//
//  GetBookListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 获取图书列表
 ******/
#import "GetBookListRequst.h"
@interface GetBookListRequst()<AFNetworkRequestDatasource>
@end
@implementation GetBookListRequst
-(void)GetBookListRequstWithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withchaperid :(NSString *)chaperid withauthor :(NSString *)author withkeyword :(NSString *)keyword withbooktype :(NSString *)booktype withisdaodu :(NSString *)isdaodu withistuijian :(NSString *)istuijian withishost :(NSString *)ishost withquxian :(NSString *)quxian withxuexiao :(NSString *)xuexiao :(GetBookListblcok)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetBookList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"chaperid":chaperid,
                                 @"author":author,
                                 @"keyword":keyword,
                                 @"booktype":booktype,
                                 @"isdaodu":isdaodu,
                                 @"ishost":ishost,
                                 @"istuijian":istuijian,
                                 @"quxian":quxian,
                                 @"xuexiao":xuexiao};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
//        NSLog(@"获取图书列表 %@",responseObject);
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}



@end
