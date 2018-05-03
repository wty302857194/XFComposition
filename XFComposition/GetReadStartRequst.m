//
//  GetReadStartRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 获取阅读排行
 ******/
#import "GetReadStartRequst.h"
@interface GetReadStartRequst()<AFNetworkRequestDatasource>
@end
@implementation GetReadStartRequst
-(void)GetReadStartRequstwithflag :(NSString *)flag withnum :(NSString *)num :(GetReadStartblcok)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetReadStart",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"flag":flag,
                                 @"num":num
                                 };
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        
        block(responseObject);
//        NSLog(@"获取阅读排行%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
