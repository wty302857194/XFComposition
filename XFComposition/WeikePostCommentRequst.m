//
//  WeikePostCommentRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/9.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*******
 添加评论
 *******/
#import "WeikePostCommentRequst.h"
@interface WeikePostCommentRequst()<AFNetworkRequestDatasource>

@end
@implementation WeikePostCommentRequst
-(void)WeikePostCommentRequstwithuserid :(NSString *)userid withmodelid :(NSString *)modelid withclassid :(NSString *)classid withuserip :(NSString *)userip withCommentinfo :(NSString *)Commentinfo :(WeikePostCommentBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"PostComment",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userid,
                                 @"modelid":modelid,
                                 @"classid":classid,
                                 @"userip":userip,
                                 @"Commentinfo":Commentinfo
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
        
//        NSLog(@"添加评论%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
