//
//  Microdetailrequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "Microdetailrequst.h"
/******
 微课堂详情接口
 
*******/
@interface Microdetailrequst ()<AFNetworkRequestDatasource>
@end
@implementation Microdetailrequst
-(void)GetmicroInfoWithClassId :(NSString *)classId withUserId:(NSString *)userId :(GetmicrodetailInfo)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMicroClassInfo",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"classId":classId,
                                 @"userId":userId};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
//        NSLog(@"视频%@",responseObject);
    }];
    
    
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
    
}

@end
