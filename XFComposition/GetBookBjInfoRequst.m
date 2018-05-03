//
//  GetBookBjInfoRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 获取读书笔记详细
 *******/
#import "GetBookBjInfoRequst.h"
@interface GetBookBjInfoRequst()<AFNetworkRequestDatasource>

@end
@implementation GetBookBjInfoRequst
-(void)GetBookBjInfoRequstWithbjid :(NSString *)bjid :(GetBookBjInfoblcok)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetBookBjInfo",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"bjid":bjid
                                 
                                 };
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        
        block(responseObject);
        NSLog(@"获取读书笔记详细%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
