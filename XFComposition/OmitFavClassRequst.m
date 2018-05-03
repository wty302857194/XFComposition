
//
//  OmitFavClassRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 取消收藏
 ******/
#import "OmitFavClassRequst.h"
@interface OmitFavClassRequst ()<AFNetworkRequestDatasource>

@end
@implementation OmitFavClassRequst
-(void)OmitFavClassRequstWithclassID :(NSString *)classID  withuserid:(NSString *)userid :(OmitFavClassBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"OmitFavClass",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"classID":classID,
                                 @"userid":userid
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"微课取消收藏-%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
