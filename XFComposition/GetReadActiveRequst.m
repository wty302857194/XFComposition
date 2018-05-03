//
//  GetReadActiveRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 获取活动列表
 *****/
#import "GetReadActiveRequst.h"
@interface GetReadActiveRequst()<AFNetworkRequestDatasource>

@end
@implementation GetReadActiveRequst
-(void)GetReadActiveRequstwithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withkeyword :(NSString *)keyword withActiveTypeID :(NSString *)ActiveTypeID :(GetReadActiveBlock)block{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetReadActive",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"keyword":keyword,
                                 @"ActiveTypeID":ActiveTypeID
                                 
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@"获取活动列表%@",responseObject);
        [SVProgressHUD dismiss];
    }];
    
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
