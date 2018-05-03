//
//  DaxieTeacherRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 答谢教师
 *****/
#import "DaxieTeacherRequst.h"
@interface DaxieTeacherRequst()<AFNetworkRequestDatasource>

@end
@implementation DaxieTeacherRequst
-(void)DaxieTeacherRequstWithuserId :(NSString *)userId withworkId :(NSString *)workId :(DaxieTeacherBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMyActiveWorkList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userId":userId,
                                 @"workId":workId
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"答谢教师%@",responseObject);
    
    }];

}
-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
