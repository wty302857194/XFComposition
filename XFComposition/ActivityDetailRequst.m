//
//  ActivityDetailRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 活动详情
 ******/
#import "ActivityDetailRequst.h"
@interface ActivityDetailRequst ()<AFNetworkRequestDatasource>
@end

@implementation ActivityDetailRequst
-(void)ActivityDetailwithActiveID:(NSString *)type :(ActivityDetailRequstBlock)block{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetActiveInfo",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"ActiveID":type};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        [SVProgressHUD dismiss];
        NSLog(@"---%@",responseObject);
        
        
    }];

    
    
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
