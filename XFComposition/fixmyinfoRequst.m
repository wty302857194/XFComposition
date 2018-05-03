//
//  fixmyinfoRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/****
 实名认证
 *****/
#import "fixmyinfoRequst.h"
@interface fixmyinfoRequst()<AFNetworkRequestDatasource>

@end
@implementation fixmyinfoRequst
-(void)fixmyinfoRequstwithusername :(NSString *)username withusersex :(NSString *)usersex withusertype :(NSString *)usertype withuserguid :(NSString *)userguid withuserphone :(NSString *)userphone withuseremail :(NSString *)useremail withuserbrith :(NSString *)userbrith withqqnum :(NSString *)qqnum withclassid :(NSString *)classid withuserid :(NSString *)userid :(fixmyinfoBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"fixmyinfo",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"username":username,
                                 @"usersex":usersex,
                                 @"usertype":usertype,
                                 @"userguid":userguid,
                                 @"userphone":userphone,
                                 @"useremail":useremail,
                                 @"userbrith":userbrith,
                                 @"qqnum":qqnum,
                                 @"classid":classid,
                                 @"userid":userid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"实名认证%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
