//
//  GetSubejectRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*******
 获取图书下面的题目信息和参与人数的信息数据
 *******/
#import "GetSubejectRequst.h"
@interface GetSubejectRequst()<AFNetworkRequestDatasource>
@end
@implementation GetSubejectRequst
-(void)GetSubejectRequstwithbookid :(NSString *)bookid :(GetSubejectblcok)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetSubeject",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"bookid":bookid
                                 
                                 };
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        
        block(responseObject);
//        NSLog(@"获取图书下面的题目信息和参与人数的信息数据%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
