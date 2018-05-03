//
//  CommWriteListRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "CommWriteListRequst.h"

/****
 获取习作列表
 ****/
@interface CommWriteListRequst ()<AFNetworkRequestDatasource>

@end
@implementation CommWriteListRequst
-(void)Comm_GetWriteListrequstWithindex :(NSNumber *)pageIndex withpagesiz:(NSString *)pagesize withgradid:(NSString *)gardeID withtypeid:(NSString *)typeID withishot:(NSString *)ishost withtuijian:(NSString *)istuijian withlabelid:(NSString *)labelId withkeword:(NSString *)keyWord  BlogStatic :(NSString *)BlogStatic  :(GetwiritlistRequst)block{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetWriteList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":pageIndex,
                                 @"PageSize":pagesize,
                                 @"userid":@"0",
                                 @"typeid":typeID,
                                 @"gardeId":gardeID,
                                 @"ishost":ishost,
                                 @"istuijian":istuijian,
                                 @"BlogStatic":BlogStatic,
                                 @"keyword":keyWord,
                                 @"labelid":labelId
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        block(responseObject);
//                NSLog(@"习作=-=-%@",responseObject);
        [SVProgressHUD dismiss];
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
