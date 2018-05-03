//
//  PublicTextTitleRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/30.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/****
 发布阅读测试到圈子
 *****/
#import "PublicTextTitleRequst.h"
@interface PublicTextTitleRequst()<AFNetworkRequestDatasource>

@end
@implementation PublicTextTitleRequst
-(void)PublicTextTitleRequstwithGroupId :(NSString *)GroupIds withPageId :(NSString *)PageId withuserid :(NSString *)userid :(PublicTextTitleBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"PublicTextTitle",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"GroupIds":GroupIds,
                                 @"PageId":PageId,
                                 @"userid":userid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@" 发布阅读测试到圈子%@",responseObject);
        
        
    }];
    
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
