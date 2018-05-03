//
//  DelBookBJRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 删除用户读书笔记
 *****/
#import "DelBookBJRequst.h"
@interface DelBookBJRequst()<AFNetworkRequestDatasource>
@end
@implementation DelBookBJRequst
-(void)DelBookBJRequstWithids :(NSString *)ids withFlag :(NSString *)Flag withuserid :(NSString *)userid :(DelBookBJBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"DelBookBJ",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"ids":ids,
                                 @"Flag":Flag,
                                 @"userid":userid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@" 删除用户读书笔记%@",responseObject);
        
        
    }];
    


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
