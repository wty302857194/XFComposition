//
//  GetBookTypeRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 习作内容
 *****/
#import "GetBookTypeRequst.h"
@interface GetBookTypeRequst()<AFNetworkRequestDatasource>
@end
@implementation GetBookTypeRequst
-(void)GetBookTypeRequst :(GetBookTypeblcok)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetBookType",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9"
                                 
                                 };
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        
        block(responseObject);
//        NSLog(@"获取年级列表%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
