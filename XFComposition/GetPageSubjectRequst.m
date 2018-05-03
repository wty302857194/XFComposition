//
//  GetPageSubjectRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/30.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/****
 老师账号浏览
 *****/
#import "GetPageSubjectRequst.h"
@interface GetPageSubjectRequst()<AFNetworkRequestDatasource>

@end
@implementation GetPageSubjectRequst

-(void)GetPageSubjectRequstwithpageid :(NSString *)pageid  withuserid :(NSString *)userid :(GetPageSubjectResultBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetPageSubject",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"pageid":pageid,
                                 @"userid":userid
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@" 浏览%@",responseObject);
        
        
    }];
    
}

-(void)GetBookSubjectRequstwithpageid :(NSString *)bookid :(GetPageSubjectResultBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetBookSubject",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"bookid":bookid,
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        //        NSLog(@" 浏览%@",responseObject);
        
        
    }];
}

-(void)PostAnswerRequstwithpageid :(NSString *)bookid  withuserid :(NSString *)userid  daan:(NSString *)daan :(GetPageSubjectResultBlock)block
{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"PostAnswer",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"bookid":bookid,
                                 @"userid":userid,
                                 @"answerInfo":daan,
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        //        NSLog(@" 浏览%@",responseObject);
        
        
    }];
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
    
}
@end
