//
//  HomeGetClassRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/4.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 
 *****/
#import "HomeGetClassRequst.h"
@interface HomeGetClassRequst ()<AFNetworkRequestDatasource>

@end
@implementation HomeGetClassRequst
-(void)HomeGetClassRequst:(requstBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetRecommodClass",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"changeId":@"3"};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
                block(responseObject);
//                NSLog(@"%@",responseObject);
//                NSLog(@"%@",responseObject[@"ret_data"][@"pageInfo"][0][@"BlogContent"]);
//                NSLog(@"%@",responseObject[@"ret_data"][@"pageInfo"][0][@"BlogTitle"]);
                
           
        
    }];


}

-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
