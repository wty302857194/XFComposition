//
//  DeleteBookRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*******
 删除图书
 *******/
#import "DeleteBookRequst.h"
@interface DeleteBookRequst()<AFNetworkRequestDatasource>

@end
@implementation DeleteBookRequst
-(void)DeleteBookRequstWithbookids :(NSString *)bookids :(DeleteBookBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"DeleteBook",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"bookids":bookids
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@" 删除图书%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
