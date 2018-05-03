//
//  GetBlogInfoRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/********
 稿件内容
 *********/
#import "GetBlogInfoRequst.h"
@interface GetBlogInfoRequst()<AFNetworkRequestDatasource>

@end

@implementation GetBlogInfoRequst

-(void)GetBlogInfoRequstWithblogid :(NSString *)blogid :(GetBlogInfoBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetBlogInfo",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"blogid":blogid,
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
        
//        NSLog(@"稿件内容%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
