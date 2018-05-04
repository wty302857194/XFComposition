//
//  HomeBookRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/4.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/****
 阅读与评测
 ****/
#import "HomeBookRequst.h"
#import "BookModel.h"
@interface HomeBookRequst ()<AFNetworkRequestDatasource>

@end
@implementation HomeBookRequst

-(void)HomeGetBookListWithchaperid :(NSString*)istuijian :(NSString *)pagesize :(NSString *)isHost :(NSString *)quxian :(NSString *)student :(NSString *)teacher :(GetBookListRequst)block{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetBookList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":@"1",
                                 @"PageSize":pagesize,
                                 @"chaperid":@"0",
                                 @"author":@"",
                                 @"keyword":@"",
                                 @"booktype":@"-1",
                                 @"isdaodu":@"0",
                                 @"ishost":isHost,
                                 @"istuijian":istuijian,
                                 @"quxian":quxian,
                                 @"student":student,
                                 @"teacher":teacher
                                 };
    NSLog(@"%@",parameters);
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
        [SVProgressHUD dismiss];
    }];
    
    
    
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
