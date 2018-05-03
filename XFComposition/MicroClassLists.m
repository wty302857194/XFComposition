//
//  MicroClassLists.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicroClassLists.h"
@interface MicroClassLists ()<AFNetworkRequestDatasource>
@end
@implementation MicroClassLists
-(void)GetmicrListWith :(NSString *)Fristparameter :(NSString *)Secondeparameters :(NSString *)Thridparameters :(micLists)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMicroClassList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"changeId":Fristparameter,
                                 @"masterId":Secondeparameters,
                                 @"subjectId":Thridparameters,
                                 @"PageIndex":@"1",
                                 @"PageSize":@"20",
                                 @"prostatic":@"-1",
                                 @"recommed":@"-1",
                                 @"timeSpan":@"0"};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
                block(responseObject);
                //                                NSLog(@"%@",responseObject);
        
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
