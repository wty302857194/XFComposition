//
//  DelPageInfoRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 删除试卷
 *****/
#import "DelPageInfoRequst.h"
@interface DelPageInfoRequst()<AFNetworkRequestDatasource>

@end
@implementation DelPageInfoRequst
-(void)DelPageInfoRequstwithgid :(NSString *)gid :(DelPageInfoBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"DelPageInfo",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"gid":gid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@" 删除试卷%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
