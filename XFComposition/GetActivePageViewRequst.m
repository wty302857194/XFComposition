//
//  GetActivePageViewRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/****
 获取试卷预览
 ****/
#import "GetActivePageViewRequst.h"
@interface GetActivePageViewRequst()<AFNetworkRequestDatasource>

@end
@implementation GetActivePageViewRequst
-(void)GetActivePageViewRequstwithSubjectid :(NSString *)Subjectid :(GetActivePageViewBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetActivePageView",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"Subjectid":Subjectid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"获取试卷预览%@",responseObject);
        
        
    }];
    
}
-(NSString *)NetworkRequestBaseURLString{
    
    return APIurl;
}
@end
