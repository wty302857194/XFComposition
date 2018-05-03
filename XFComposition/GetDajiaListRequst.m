//
//  GetDajiaListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 大家语文列表
 *****/
#import "GetDajiaListRequst.h"
@interface GetDajiaListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetDajiaListRequst
-(void)GetDajiaListRequstwithClassid :(NSString *)Classid withdeptid :(NSString *)deptid withNewsType :(NSString *)NewsType withTags :(NSString *)Tags withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize :(GetDajiaListBlock)block{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetDajiaList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"Classid":Classid,
                                 @"deptid":deptid,
                                 @"NewsType":NewsType,
                                 @"Tags":Tags,
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"大家语文列表%@",responseObject);
        [SVProgressHUD dismiss];
    }];
    
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
