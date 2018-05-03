//
//  GetLabelTypeTreelistAllRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/****
 获取所有习作标签
 ****/
#import "GetLabelTypeTreelistAllRequst.h"
@interface GetLabelTypeTreelistAllRequst()<AFNetworkRequestDatasource>

@end
@implementation GetLabelTypeTreelistAllRequst
-(void)GetLabelTypeTreelistAllRequstwithID :(NSString *)ID withFlag :(NSString *)Flag withmodelid :(NSString *)modelid :(GetLabelTypeTreelistAllBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetLabelTypeTreelistAll",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"ID":ID,
                                 @"Flag":Flag,
                                 @"modelid":modelid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@"获取所有习作标签%@",responseObject);
        
    }];
    
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
    
}
@end
