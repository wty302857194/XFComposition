//
//  GetDeptSchoolListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 获取区学校列表
 *****/
#import "GetDeptSchoolListRequst.h"
@interface GetDeptSchoolListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetDeptSchoolListRequst
-(void)GetDeptSchoolListRequstWithblock :(GetDeptSchoolListblcok)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetDeptSchoolList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
//                                 @"deptid": @"1"
                                 };
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        
        block(responseObject);
//        NSLog(@"获取区学校列表%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
