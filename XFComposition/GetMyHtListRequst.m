
//
//  GetMyHtListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*******
 获取指定圈子的帖子列表
 *******/
#import "GetMyHtListRequst.h"
@interface GetMyHtListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetMyHtListRequst
-(void)GetMyHtListRequstWithtypeId :(NSString *)typeId withgroupId :(NSString *)groupId withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withflag :(NSString *)flag withkeyWord :(NSString *)keyWord :(GetMyHtListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMyHtList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"typeId":typeId,
                                 @"groupId":groupId,
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"flag":flag,
                                 @"keyWord":keyWord
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@"获取指定圈子的帖子列表%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
