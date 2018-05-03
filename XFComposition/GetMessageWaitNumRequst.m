//
//  GetMessageWaitNumRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 我的未读消息数目
 *****/
#import "GetMessageWaitNumRequst.h"
@interface GetMessageWaitNumRequst()<AFNetworkRequestDatasource>

@end
@implementation GetMessageWaitNumRequst
-(void)GetMessageWaitNumRequstWithuserid :(NSString *)userid :(GetMessageWaitNumBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMessageWaitNum",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userid
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"我的未读消息数目%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
