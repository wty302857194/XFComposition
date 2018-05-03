//
//  LoginRequest.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/1.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*********
 登录
 *********/
#import "LoginRequest.h"
@interface LoginRequest ()<AFNetworkRequestDatasource>
@end
@implementation LoginRequest
-(void)LoginRequstphoneText:(NSString *)phonetext password:(NSString *)passwor :(requstBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;

    NSDictionary *parameters = @{@"Action":@"LoginServer",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"UserId":phonetext,
                                 @"Pwd":passwor};

    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        block(responseObject);
        NSLog(@"登录%@",responseObject);
    }];

}
- (NSString *)NetworkRequestBaseURLString {
    return @"http://xf.vqune.com/wsdl/AppService.ashx";
}
@end
