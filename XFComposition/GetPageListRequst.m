//
//  GetPageListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 做题记录
 ******/
#import "GetPageListRequst.h"
@interface GetPageListRequst()<AFNetworkRequestDatasource>
@end
@implementation GetPageListRequst
-(void)GetPageListRequstwithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withchaperid :(NSString *)chaperid withkeyword :(NSString *)keyword withscheckype :(NSString *)scheckype withuserid :(NSString *)userid :(GetPageListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMyTestList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"chaperid":chaperid,
                                 @"keyword":keyword,
                                 @"scheckype":scheckype,
                                 @"userid":userid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@"做题记录%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
