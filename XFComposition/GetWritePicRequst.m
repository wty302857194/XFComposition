//
//  GetWritePicRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 手机版获取文章图片列表
 ******/
#import "GetWritePicRequst.h"
@interface GetWritePicRequst()<AFNetworkRequestDatasource>
@end
@implementation GetWritePicRequst
-(void)GetWritePicRequstwithblogid :(NSString *)blogid :(GetWritePicBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetWritePic",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"blogid":blogid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@" 手机版获取文章图片列表%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
