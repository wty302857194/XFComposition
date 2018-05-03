//
//  Ringrequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*********
圈子列表
 **********/
#import "Ringrequst.h"
@interface Ringrequst ()<AFNetworkRequestDatasource>
@end
@implementation Ringrequst
-(void)GetRingList :(NSInteger)page :(ringReqsut)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetGroupList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"typeId":@"0",
                                 @"GroupStatic":@"1",
                                 @"PageIndex":[NSString stringWithFormat:@"%ld",(long)page],
                                 @"PageSize":@"10",
                                 @"isTuijian":@"0",
                                 @"isHost":@"0",
                                 @"keyWord":@""};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
                        block(responseObject);
//                NSLog(@"ring%@",responseObject);
    
        
    }];

//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager POST:@"1" parameters:@"" progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
//    }];



}
-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
