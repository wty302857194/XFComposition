
//
//  AddBookReadInfoRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 添加读书记录标记信息
 *****/
#import "AddBookReadInfoRequst.h"
@interface AddBookReadInfoRequst()<AFNetworkRequestDatasource>

@end
@implementation AddBookReadInfoRequst
-(void)AddBookReadInfoRequstWithBookId :(NSString *)BookId withCurrentReadNum :(NSString *)CurrentReadNum withContentTag :(NSString *)ContentTag withContent :(NSString *)Content withuserid :(NSString *)userid :(AddBookReadInfoblcok)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"AddBookReadInfo",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"BookId":BookId,
                                 @"CurrentReadNum":CurrentReadNum,
                                 @"ContentTag":ContentTag,
                                 @"Content":Content,
                                 @"userid":userid
                                 };
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        
        block(responseObject);
//        NSLog(@"添加读书记录标记信息%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
