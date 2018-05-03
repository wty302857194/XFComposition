//
//  GetTeachNeedCheckListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 获取制定志愿教师需要批阅的习作列表
 ******/
#import "GetTeachNeedCheckListRequst.h"
@interface GetTeachNeedCheckListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetTeachNeedCheckListRequst
-(void)GetTeachNeedCheckListRequstWithuserId :(NSString *)userId withactiveId :(NSString *)activeId withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withcheckType :(NSString *)checkType withworkName :(NSString *)workName :(GetTeachNeedCheckListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetTeachNeedCheckList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userId":userId,
                                 @"activeId":activeId,
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"checkType":checkType,
                                 @"workName":workName
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@" 获取制定志愿教师需要批阅的习作列表%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
