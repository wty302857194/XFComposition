//
//  GetWritePicRemarkRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 手机版获取文章图片点评内容
 ******/
#import "GetWritePicRemarkRequst.h"
@interface GetWritePicRemarkRequst()<AFNetworkRequestDatasource>

@end
@implementation GetWritePicRemarkRequst
-(void)GetWritePicRemarkRequstwithpicid :(NSString *)picid :(GetWritePicRemarkBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetWritePicRemark",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"picid":picid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@" 手机版获取文章图片点评内容%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
