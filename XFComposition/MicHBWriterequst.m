//
//  MicHBWriterequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/15.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicHBWriterequst.h"
@interface MicHBWriterequst ()<AFNetworkRequestDatasource>

@end
@implementation MicHBWriterequst
-(void)MicHBWriterequstWithclassId :(NSString *)classID ids:(NSString *)ids withModelld :(NSString *)modeleid withUserID :(NSString *)userid :(HBWriteBlock)blcok{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"HBWrite",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"classId":classID,
                                 @"modelId":modeleid ,
                                 @"userid":userid,
                                 @"ids":ids,
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        blcok(responseObject);
        
        NSLog(@"%@",responseObject);
    }];
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
