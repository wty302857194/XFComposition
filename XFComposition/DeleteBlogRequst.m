//
//  DeleteBlogRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 删除习作
 *****/
#import "DeleteBlogRequst.h"
@interface DeleteBlogRequst()<AFNetworkRequestDatasource>

@end
@implementation DeleteBlogRequst
-(void)DeleteBlogRequstWithNoticeIds :(NSString *)NoticeIds withUserid :(NSString *)Userid withFlag :(NSString *)Flag :(DeleteBlogtBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"DeleteBlog",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"NoticeIds":NoticeIds,
                                 @"Userid":Userid,
                                 @"Flag":Flag
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@"删除习作%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
