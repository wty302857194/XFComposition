//
//  DeleteCommentCheckRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/22.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 手机版删除点评内容
 ******/
#import "DeleteCommentCheckRequst.h"
@interface DeleteCommentCheckRequst()<AFNetworkRequestDatasource>

@end
@implementation DeleteCommentCheckRequst
-(void)DeleteCommentCheckRequstwithRemarkID :(NSString *)RemarkID withuserid :(NSString *)userid :(DeleteCommentCheckBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"DeleteCommentCheck",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"RemarkID":RemarkID,
                                 @"userid":userid
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@" 手机版删除点评内容%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
