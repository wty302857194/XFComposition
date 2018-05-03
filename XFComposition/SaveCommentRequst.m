//
//  SaveCommentRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/***
 圈子添加评论
 ****/
#import "SaveCommentRequst.h"
@interface SaveCommentRequst()<AFNetworkRequestDatasource>

@end
@implementation SaveCommentRequst
-(void)SaveCommentRequstwithtitleId :(NSString *)titleId withuserId :(NSString *)userId withtypeFlag :(NSString *)typeFlag withcommentInfo :(NSString *)commentInfo :(SaveCommentBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"SaveComment",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"titleId":titleId,
                                 @"userId":userId,
                                 @"typeFlag":typeFlag,
                                 @"commentInfo":commentInfo
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"圈子添加评论%@",responseObject);
        
    }];
    
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
    
}
@end
