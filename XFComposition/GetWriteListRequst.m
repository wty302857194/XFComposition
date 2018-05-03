//
//  GetWriteListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 习作列表
 *******/
#import "GetWriteListRequst.h"
@interface GetWriteListRequst()<AFNetworkRequestDatasource>

@end
@implementation GetWriteListRequst
-(void)GetWriteListRequstWithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withuserid :(NSString *)userid withtypeid :(NSString *)typeID withgardeId :(NSString *)gardeId withishost :(NSString *)ishost withistuijian :(NSString *)istuijian withlabelid :(NSString *)labelid withkeyword :(NSString *)keyword BlogStatic:(NSString *)BlogStatic  :(GetWriteListBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetWriteList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"userid":userid,
                                 @"typeid":typeID,
                                 @"gardeId":gardeId,
                                 @"ishost":ishost,
                                 @"istuijian":istuijian,
                                 @"labelid":labelid,
                                 @"BlogStatic":@"-1",
                                 @"keyword":keyword
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//                NSLog(@"---%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
