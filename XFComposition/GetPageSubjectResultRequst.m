//
//  GetPageSubjectResultRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/27.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/****
 学生做题结果浏览
 ****/
#import "GetPageSubjectResultRequst.h"
@interface GetPageSubjectResultRequst()<AFNetworkRequestDatasource>

@end
@implementation GetPageSubjectResultRequst
-(void)GetPageSubjectResultRequstwithpageid :(NSString *)pageid withuserid :(NSString *)userid :(GetPageSubjectResultBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetPageSubjectResult",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"pageid":pageid,
                                 @"userid":userid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        
        NSLog(@" 学生做题结果浏览%@",responseObject);
        
    }];
    
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
    
}
@end
