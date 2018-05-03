//
//  GetGJListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*********
 获取作文列表
 *********/
#import "GetGJListRequst.h"
@interface GetGJListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetGJListRequst
-(void)GetGJListRequstWithuserId :(NSString *)userId withPageIndex :(NSString *)pageindex withPagesize :(NSString *)pagesize withTypeid :(NSString *)typeId withModelid :(NSString *)modelid  :(GetGJListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetGJList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userId,
                                 @"PageIndex":pageindex ,
                                 @"PageSize":pagesize,
                                 @"typeid":typeId,
                                
                                 @"modelid":modelid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
        
//        NSLog(@"微课作文%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
