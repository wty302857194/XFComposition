//
//  GetStaticBookBjRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 获取在读想读已读的读书笔记信息
 *****/
#import "GetStaticBookBjRequst.h"
@interface GetStaticBookBjRequst()<AFNetworkRequestDatasource>

@end
@implementation GetStaticBookBjRequst
-(void)GetStaticBookBjRequstWithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withflag :(NSString *)flag withistuijian :(NSString *)istuijian :(GetStaticBookBjblcok)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetStaticBookBj",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"flag":flag,
                                 @"istuijian":istuijian
                                 };
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        
        block(responseObject);
//        NSLog(@"获取在读想读已读的读书笔记信息%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
