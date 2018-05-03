//
//  CreateGroupRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 创建圈子
 *****/
#import "CreateGroupRequst.h"
@interface CreateGroupRequst()<AFNetworkRequestDatasource>

@end
@implementation CreateGroupRequst
-(void)CreateGroupRequstwithid :(NSString *)IFid withuserid :(NSString *)userid withgroupname :(NSString *)groupname withtypeid :(NSString *)typeID withgroupinfo :(NSString *)groupinfo withgroupicon :(NSString *)groupicon :(CreateGroupBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"CreateGroup",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"id":IFid,
                                 @"userid":userid,
                                 @"groupname":groupname,
                                 @"typeid":typeID,
                                 @"groupinfo":groupinfo,
                                 @"groupicon":groupicon,
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"创建圈子%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
