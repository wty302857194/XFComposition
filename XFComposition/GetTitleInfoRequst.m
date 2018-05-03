//
//  GetTitleInfoRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/22.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*********
获取帖子详细
 ********/
#import "GetTitleInfoRequst.h"
@interface GetTitleInfoRequst()<AFNetworkRequestDatasource>

@end
@implementation GetTitleInfoRequst
-(void)GetTitleInfoRequstwithid :(NSString *)ringID :(GetTitleInfoBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetTitleInfo",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"id":ringID};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@"获取帖子详细%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
