//
//  GetGroupUserRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/****
 获取指定圈子的用户数据
 ****/
#import "GetGroupUserRequst.h"
@interface GetGroupUserRequst()<AFNetworkRequestDatasource>

@end
@implementation GetGroupUserRequst
-(void)GetGroupUserRequstwithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withgroupId :(NSString *)groupId :(GetGroupUserBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetGroupUser",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"groupId":groupId
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"获取指定圈子的用户数据%@",responseObject);
        
        
    }];
    
}
-(NSString *)NetworkRequestBaseURLString{
    
    return APIurl;
}
@end
