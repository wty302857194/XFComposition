//
//  getBookSubjectResultRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 获取用户做图书关联试题结果
 *****/
#import "getBookSubjectResultRequst.h"
@interface getBookSubjectResultRequst()<AFNetworkRequestDatasource>

@end
@implementation getBookSubjectResultRequst
-(void)getBookSubjectResultRequstwithbookid :(NSString *)bookid withuserid :(NSString *)userid :(getBookSubjectResultBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"getBookSubjectResult",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"bookid":bookid,
                                 @"userid":userid

                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@"获取用户做图书关联试题结果%@",responseObject);
        
        
    }];
    
}
-(NSString *)NetworkRequestBaseURLString{
    
    return APIurl;
}
@end
