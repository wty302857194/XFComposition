//
//  GetVoleTeacherRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*******
 获取老师列表
 *******/
#import "GetVoleTeacherRequst.h"
@interface GetVoleTeacherRequst ()<AFNetworkRequestDatasource>

@end
@implementation GetVoleTeacherRequst
-(void)GetVoleTeacherRequstWithistuijian :(NSString *)istuijian withtop :(NSString *)top :(GetVoleTeacherblock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetVoleTeacher",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"istuijian":istuijian,
                                 @"top":top};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        block(responseObject);
//        NSLog(@"老师列表%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
