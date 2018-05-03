//
//  GetTitleCommentRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/1.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/****
 获取帖子的评论
 ****/
#import "GetTitleCommentRequst.h"
@interface GetTitleCommentRequst()<AFNetworkRequestDatasource>

@end
@implementation GetTitleCommentRequst
-(void)GetTitleCommentRequstwithtitleId :(NSString *)titleId withmasterId :(NSString *)masterId withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withmasteOnly :(NSString *)masteOnly withorderFlag :(NSString *)orderFlag :(GetTitleCommentBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetTitleComment",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"titleId":titleId,
                                 @"masterId":masterId,
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"masteOnly":masteOnly,
                                 @"orderFlag":orderFlag
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"获取帖子的评论%@",responseObject);
    
    }];
    
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
