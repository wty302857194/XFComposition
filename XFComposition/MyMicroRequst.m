//
//  MyMicroRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 我的微课
 ******/
#import "MyMicroRequst.h"
@interface MyMicroRequst()<AFNetworkRequestDatasource>

@end
@implementation MyMicroRequst
-(void)MyMicroRequstWithuserid :(NSString *)userid withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize :(MyMicroBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMyWeikeCol",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userid,
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"---%@",responseObject);
        
        
    }];

    
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
