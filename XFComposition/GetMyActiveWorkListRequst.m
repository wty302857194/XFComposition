//
//  GetMyActiveWorkListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 获取我提交的所有习作
 *****/
#import "GetMyActiveWorkListRequst.h"
@interface GetMyActiveWorkListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetMyActiveWorkListRequst
-(void)GetMyActiveWorkListRequstWithuserId :(NSString *)userId withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withworkName :(NSString *)workName withactiveId :(NSString *)activeId withactiveItemId :(NSString *)activeItemId withwriteStatic :(NSString *)writeStatic withwriteTypeId :(NSString *)writeTypeId :(GetMyActiveWorkListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMyActiveWorkList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userId":userId,
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"workName":workName,
                                 @"activeId":activeId,
                                 @"activeItemId":activeItemId,
                                 @"writeStatic":writeStatic,
                                 @"writeTypeId":writeTypeId
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@"获取我提交的所有习作%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
