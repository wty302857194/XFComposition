//
//  WeikeGoodcolActionRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/9.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 分享或者收藏
 *****/
#import "WeikeGoodcolActionRequst.h"
@interface WeikeGoodcolActionRequst()<AFNetworkRequestDatasource>

@end
@implementation WeikeGoodcolActionRequst

-(void)WeikeGoodcolActionRequstwith :(NSString *)userid withweikeid :(NSString *)weikeid withtypeflag :(NSString *)typeflag :(WeikeGoodcolActionBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"WeikeGoodcolAction",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userid,
                                 @"weikeid":weikeid,
                                 @"typeflag":typeflag
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
      
            block(responseObject);
        

        
        NSLog(@"分享或者收藏%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
