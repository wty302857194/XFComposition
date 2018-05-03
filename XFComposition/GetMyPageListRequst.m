//
//  GetMyPageListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 我的试卷列表
 *****/
#import "GetMyPageListRequst.h"
@interface GetMyPageListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetMyPageListRequst
-(void)GetMyPageListRequstwithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withprivatpage :(NSString *)privatpage withuserid :(NSString *)userid :(GetMyPageListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetPageList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"privatpage":privatpage,
                                 @"userid":userid

                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@" 我的试卷列表%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
