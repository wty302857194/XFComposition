//
//  GetActiveApplyTeacherList.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetActiveApplyTeacherList.h"
@interface GetActiveApplyTeacherList()<AFNetworkRequestDatasource>
@end

@implementation GetActiveApplyTeacherList
-(void)GetActiveApplyTeacherListWithPageIndex :(NSInteger)pageindex withPageSize :(NSInteger)PageSize withactiveid :(NSString *)activeid withteacherstatic :(NSString *)teacherstatic :(GetActiveApplyTeacherListrequst)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetActiveApplyTeacherList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":[NSString stringWithFormat:@"%ld",(long)pageindex],
                                 @"PageSize":[NSString stringWithFormat:@"%ld",(long)PageSize],
                                 @"activeid":activeid,
                                 @"teacherstatic":teacherstatic};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        block(responseObject);
//        NSLog(@"88888888%@",responseObject);
        
        
    }];



}


-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
