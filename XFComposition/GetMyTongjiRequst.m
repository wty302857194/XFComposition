//
//  GetMyTongjiRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 个人中心推荐图书 统计
 *****/
#import "GetMyTongjiRequst.h"
@interface GetMyTongjiRequst()<AFNetworkRequestDatasource>
@end
@implementation GetMyTongjiRequst
-(void)GetMyTongjiRequstwithuserid :(NSString *)userid :(GetMyTongjiBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMyTongji",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userid
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@" 个人中心推荐图书 统计%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
