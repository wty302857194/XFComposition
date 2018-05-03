//
//  GetMessageListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/24.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/****
 我的消息
 *****/
#import "GetMessageListRequst.h"
@interface GetMessageListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetMessageListRequst
-(void)GetMessageListRequstwithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withtype :(NSString *)type withflag :(NSString *)flag withuserid :(NSString *)userid :(GetMessageListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMessageList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"type":type,
                                 @"flag":flag,
                                 @"userid":userid
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@"我的消息%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
