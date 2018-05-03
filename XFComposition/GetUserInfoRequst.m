//
//  GetUserInfoRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 获取用户信息
 *****/
#import "GetUserInfoRequst.h"
@interface GetUserInfoRequst()<AFNetworkRequestDatasource>

@end
@implementation GetUserInfoRequst
-(void)GetUserInfoRequstwithuserid :(NSString *)userid :(GetUserInfoBlock)block{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetUserInfo",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userid
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@"获取用户信息%@",responseObject);
        [SVProgressHUD dismiss];
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
