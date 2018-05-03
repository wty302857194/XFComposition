//
//  IsVoleTeacherRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/19.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 是否为志愿老师
 ******/
#import "IsVoleTeacherRequst.h"
@interface IsVoleTeacherRequst()<AFNetworkRequestDatasource>

@end
@implementation IsVoleTeacherRequst
-(void)IsVoleTeacherRequstWithuserid :(NSString *)userid :(IsVoleTeacherblock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"IsVoleTeacher",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userid
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        block(responseObject);
        NSLog(@"是否为志愿老师%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
