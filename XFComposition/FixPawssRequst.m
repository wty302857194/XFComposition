//
//  FixPawssRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 修改密码功能
 ******/
#import "FixPawssRequst.h"
@interface FixPawssRequst()<AFNetworkRequestDatasource>

@end
@implementation FixPawssRequst
-(void)FixPawssRequstwithuserid :(NSString *)userid witholdpwd :(NSString *)oldpwd withnewpwd :(NSString *)newpwd :(FixPawssBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"FixPawss",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userid,
                                 @"oldpwd":oldpwd,
                                 @"newpwd":newpwd
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"修改密码功能%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
