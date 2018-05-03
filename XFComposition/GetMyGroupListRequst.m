//
//  GetMyGroupListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 我的圈子列表
 ******/
#import "GetMyGroupListRequst.h"
@interface GetMyGroupListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetMyGroupListRequst
-(void)GetMyGroupListRequstwithuserId :(NSString *)userId withtypeId :(NSString *)typeId withflag :(NSString *)flag withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withisTuijian :(NSString *)isTuijian withkeyWord :(NSString *)keyWord :(GetMyGroupListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMyGroupList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userId":userId,
                                 @"typeId":@"0",
                                 @"flag":flag,
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"isTuijian":@"0",
                                 @"keyWord":@""};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"我的圈子列表%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
