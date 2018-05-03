//
//  HomeActivityRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/4.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 活动
 *****/
#import "HomeActivityRequst.h"
#import "ActiveInfoModel.h"
@interface HomeActivityRequst ()<AFNetworkRequestDatasource>

@end
@implementation HomeActivityRequst
-(void)HomeGetActivityRequst :(NSString *)pagesize :(requstBlock)block{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetReadActive",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":@"1",
                                 @"PageSize":pagesize,
                                 @"keyword":@"",
                                 @"ActiveTypeID":@"0"};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"加载失败！"];
        }else{
            
            block(responseObject);
            [SVProgressHUD dismiss];
            
            
        }
        
        
    }];
    
    
    
}

-(NSString *)NetworkRequestBaseURLString{
    
    return APIurl;
}

@end
