//
//  GetMyPageSubjectListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/18.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 获取不同类型的题库
 ******/
#import "GetMyPageSubjectListRequst.h"
@interface GetMyPageSubjectListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetMyPageSubjectListRequst
-(void)GetMyPageSubjectListRequstwithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withchaperid :(NSString *)chaperid withkeyword :(NSString *)keyword withscheckype :(NSString *)scheckype withActiveid :(NSString *)Activeid withuserid :(NSString *)userid :(GetMyPageSubjectListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMyPageSubjectList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"chaperid":chaperid,
                                 @"keyword":keyword,
                                 @"scheckype":scheckype,
                                 @"Activeid":Activeid,
                                 @"userid":userid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"获取不同类型的题库%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
