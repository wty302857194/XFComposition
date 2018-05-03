//
//  GetBookBjRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/********
 读书笔记
 *******/
#import "GetBookBjRequst.h"
@interface GetBookBjRequst()<AFNetworkRequestDatasource>

@end
@implementation GetBookBjRequst
-(void)GetBookBjRequstWithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withflag:(NSString *)flag withistuijian :(NSString *)istuijian :(GetBookBjblcok)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetBookBj",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"flag":flag,
                                 @"istuijian":istuijian
                                 };
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        
        block(responseObject);
//        NSLog(@"读书笔记%@",responseObject);
        
        
    }];



}
-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
