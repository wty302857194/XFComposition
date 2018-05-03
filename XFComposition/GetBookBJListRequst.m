//
//  GetBookBJListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 获取用户的读书笔记
 *****/
#import "GetBookBJListRequst.h"
@interface GetBookBJListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetBookBJListRequst
-(void)GetBookBJListRequstWithbookid :(NSString *)bookid withremarktype :(NSString *)remarktype withistuijian :(NSString *)istuijian withremarkStatic :(NSString *)remarkStatic withkeyword :(NSString *)keyword withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withuserid :(NSString *)userid :(GetBookBJListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetBookBJList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"bookid":bookid,
                                 @"remarktype":remarktype,
                                 @"istuijian":istuijian,
                                 @"remarkStatic":remarkStatic,
                                 @"keyword":keyword,
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"userid":userid
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"获取用户的读书笔记%@",responseObject);
        
        
    }];

}

-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
