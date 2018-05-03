//
//  GetGroupTypeRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 获取圈子的类型
 ******/
#import "GetGroupTypeRequst.h"
@interface GetGroupTypeRequst()<AFNetworkRequestDatasource>

@end
@implementation GetGroupTypeRequst
-(void)GetGroupTypeRequstwith :(GetGroupTypeBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetGroupType",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9"
                
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"获取圈子的类型%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
