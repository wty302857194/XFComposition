//
//  MicroPianduanRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicroPianduanRequst.h"
/******
 获取我的片段
 *******/
@interface MicroPianduanRequst ()<AFNetworkRequestDatasource>

@end
@implementation MicroPianduanRequst
-(void)GetMricopianduanwithNoticeObject:(NSString *)noticeObject withmodelid :(NSString *)modelid withUserId:(NSString *)userid : (NSString*)pageindex :(NSString *)pagesize :(GetMricopianduanrequst)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetBlogPdList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"modelid":modelid,
                                 @"typeid":noticeObject ,
                                 @"userid":userid,
                                 @"PageIndex":pageindex,
                                 @"PageSize":pagesize};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
        
//        NSLog(@"获取片段%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
