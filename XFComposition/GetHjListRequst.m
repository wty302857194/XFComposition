//
//  GetHjListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetHjListRequst.h"
@interface GetHjListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetHjListRequst
-(void)GetHjListRequstWithblogid :(NSString *)blogid  pageindex:(NSString *)index  pagesize:(NSString *)size   :(GetHjListblock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetHjList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"pageIndex":index,
                                 @"pageSize":size,
                                 @"blogid":blogid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        block(responseObject);
        NSLog(@"好词好几%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
