//
//  GetBookInfoRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*******
 获取图书详细
 ********/
#import "GetBookInfoRequst.h"
@interface GetBookInfoRequst()<AFNetworkRequestDatasource>
@end
@implementation GetBookInfoRequst
-(void)GetBookInfoRequstWithbookid :(NSString *)bookid withuserid :(NSString *)userid :(GetBookInfoblcok)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetBookInfo",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"bookid":bookid,
                                 @"userid":userid
                                 };
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        
        block(responseObject);
                NSLog(@"获取图书详细%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
