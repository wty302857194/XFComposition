//
//  MicrotiajiaplRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*******
 添加评论接口
 *******/
#import "MicrotiajiaplRequst.h"
@interface MicrotiajiaplRequst ()<AFNetworkRequestDatasource>

@end
@implementation MicrotiajiaplRequst

-(void)MicrotianjiaPinglunWithUserid:(NSString *)userid withWeikeid:(NSString *)weikeid withUserip:(NSString *)userip withCommentinfo:(NSString *)text :(Microtianjiainforequst)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetMicroClassInfo",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userid,
                                 @"weikeid":weikeid,
                                 @"userip":userip,
                                 @"Commentinfo":text};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
//        NSLog(@"%@",responseObject);
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
