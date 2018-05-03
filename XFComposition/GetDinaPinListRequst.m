//
//  GetDinaPinListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetDinaPinListRequst.h"
@interface GetDinaPinListRequst()<AFNetworkRequestDatasource>
@end
@implementation GetDinaPinListRequst
-(void)GetDinaPinListRequswithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withclassId :(NSString *)classId withmodelId :(NSString *)modelId withkeyWord :(NSString *)keyWord :(GetDinaPinListblock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetDinaPinList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"classId":classId,
                                 @"modelId":modelId,
                                 @"keyWord":keyWord};
    NSLog(@"%@",parameters);
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        block(responseObject);
//        NSLog(@"点评%@",responseObject);
    }];
    
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
