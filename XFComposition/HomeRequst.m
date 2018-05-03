//
//  HomeRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/4.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomeRequst.h"
@interface HomeRequst ()<AFNetworkRequestDatasource>
@end
@implementation HomeRequst
-(void)HomeRequsetGetList:(requstBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
        NSDictionary *parameters = @{@"Action":@"GetWriteList",
                                     @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                     @"PageIndex":@"1",
                                     @"PageSize":@"20",
                                     @"userid":@"0",
                                     @"typeid":@"4",
                                     @"gardeId":@"5",
                                     @"ishost":@"0",
                                     @"istuijian":@"0",
                                     @"labelid":@"0",
                                     @"keyword":@""};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"%@",responseObject);
//                NSLog(@"%@",responseObject[@"ret_data"][@"pageInfo"][0][@"BlogContent"]);
//                NSLog(@"%@",responseObject[@"ret_data"][@"pageInfo"][0][@"BlogTitle"]);
//                block(re)
        
        
    }];


}
- (NSString *)NetworkRequestBaseURLString {
    return APIurl;
}
@end
