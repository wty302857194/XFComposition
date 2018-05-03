//
//  GetTeachNeedActiveListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 获取教师已经经过审核的批阅活动任务
 ******/
#import "GetTeachNeedActiveListRequst.h"
@interface GetTeachNeedActiveListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetTeachNeedActiveListRequst
-(void)GetTeachNeedActiveListRequstWithuserId :(NSString *)userId withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withkeyWord :(NSString *)keyWord :(GetTeachNeedActiveListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetTeachNeedActiveList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userId":userId,
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"keyWord":keyWord,
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@" 获取教师已经经过审核的批阅活动任务%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
