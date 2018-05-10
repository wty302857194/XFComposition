


//
//  MicoClassRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 微课堂列表
 ******/
#import "MicoClassRequst.h"
@interface MicoClassRequst ()<AFNetworkRequestDatasource>
@end
@implementation MicoClassRequst
-(void)requstGetmicListWithchangId:(NSString *)changId Withmasterid:(NSString *)masterid Withsubjectid:(NSString *)subjectid Withindex:(NSString *)pageindex Withpagesize:(NSString *)pasize Withrecommed:(NSString *)recommed Withprostatic:(NSString *)protatic Withtimespan:(NSString *)timespan :(micClassblcok)block{
//    [SVProgressHUD showWithStatus:@"正在加载..."];
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMicroClassList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"changeId":changId,
                                 @"masterId":masterid,
                                 @"subjectId":subjectid,
                                 @"PageIndex":pageindex,
                                 @"PageSize":pasize,
                                 @"recommed":recommed,
                                 @"prostatic":protatic ,
                                 @"timespan":timespan};
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        
        block(responseObject);
//        [SVProgressHUD dismiss];
        //                NSLog(@"微课堂%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
