//
//  GetBlogContentInfoRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*********
 片段内容
 *********/
#import "GetBlogContentInfoRequst.h"
@interface GetBlogContentInfoRequst()<AFNetworkRequestDatasource>

@end

@implementation GetBlogContentInfoRequst

-(void)GetBlogContentInfoRequstWithNoticeID: (NSString *)NoticeID :(GetBlogContentInfoBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetBlogContentInfo",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"NoticeID":NoticeID,
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
        
//        NSLog(@"片段内容%@",responseObject);
        
        
    }];



}

-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
