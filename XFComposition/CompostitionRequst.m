//
//  CompostitionRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/5.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 作文列表
 *******/
#import "CompostitionRequst.h"
#import "WriteListModel.h"

@interface CompostitionRequst ()<AFNetworkRequestDatasource>

@end
@implementation CompostitionRequst
-(void)GetWriteList:(NSString *)pagesize :(writelistRequst)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMicroClassList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"changeId":@"0",
                                 @"masterId":@"0",
                                 @"subjectId":@"0",
                                 @"PageIndex":@"1",
                                 @"PageSize":pagesize,
                                 @"recommed":@"-1",
                                 @"prostatic":@"-1"};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
       
        
        
        block(responseObject);
//        NSLog(@"%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
