//
//  MicroClassTypeRquset.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicroClassTypeRquset.h"
@interface MicroClassTypeRquset ()<AFNetworkRequestDatasource>

@end
@implementation MicroClassTypeRquset
-(void)GetmicrTypeWith :(NSString *)changeId :(GetmicrClass)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMicroClassType",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"changeId":changeId};
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
        //                NSLog(@"%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
