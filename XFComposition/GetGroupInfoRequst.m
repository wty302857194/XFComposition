//
//  GetGroupInfoRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 获取圈子详细
 ******/
#import "GetGroupInfoRequst.h"
@interface GetGroupInfoRequst ()<AFNetworkRequestDatasource>

@end
@implementation GetGroupInfoRequst
-(void)GetGroupInfoRequstWithgruopID :(NSString *)gruopID withuserid :(NSString *)userid :(GetGroupInfoBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetGroupInfo",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"id":gruopID,
                                 @"userid":userid};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"圈子详细%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
