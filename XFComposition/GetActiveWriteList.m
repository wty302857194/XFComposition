//
//  GetActiveWriteList.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 
 *******/
#import "GetActiveWriteList.h"
@interface GetActiveWriteList()<AFNetworkRequestDatasource>

@end
@implementation GetActiveWriteList
-(void)GetActiveWriteListWithActId :(NSString *)actId withProductionName :(NSString *)ProductionName withActiveItem: (NSString *)ActiveItem withWriteStatic :(NSString *)WriteStatic withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withWriteTypeID :(NSString *)WriteTypeID withGroupID:(NSString *)GroupID :(GetActiveWriteListRequst)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetActiveWriteList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"ActId":actId,
                                 @"ProductionName":ProductionName,
                                 @"ActiveItem":ActiveItem,
                                 @"WriteStatic":WriteStatic,
                                 @"WriteTypeID":WriteTypeID,
                                 @"GroupID":GroupID};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        block(responseObject);
//                        NSLog(@"jjjjjjj%@",responseObject);
        
        
    }];


}

-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
