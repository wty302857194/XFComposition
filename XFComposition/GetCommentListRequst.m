//
//  GetCommentListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/9.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*********
 获取指定的微课评论信息
 *********/
#import "GetCommentListRequst.h"
@interface GetCommentListRequst()<AFNetworkRequestDatasource>
@end
@implementation GetCommentListRequst

-(void)GetCommentListRequstWithclassId :(NSString *)classId withmodelId :(NSString *)modelId withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize :(GetCommentListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetCommentList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"classId":classId,
                                 @"modelId":modelId,
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
        
//        NSLog(@"获取指定的微课评论信息%@",responseObject);
        
        
    }];

    

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
