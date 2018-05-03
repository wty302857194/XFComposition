//
//  GetMybookListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*******
 我的图书信息
 *******/
#import "GetMybookListRequst.h"
@interface GetMybookListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetMybookListRequst
-(void)GetMybookListRequstWithchaperid :(NSString *)chaperid withbooktype :(NSString *)booktype withbookgrade :(NSString *)bookgrade withkeyword :(NSString *)keyword withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withuserid :(NSString *)userid :(GetMybookListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMybookList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"chaperid":chaperid,
                                 @"booktype":booktype,
                                 @"bookgrade":bookgrade,
                                 @"keyword":keyword,
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"userid":userid
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@" 我的图书信息%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
