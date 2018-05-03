//
//  JoinGroupRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/22.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/********
 加入圈子
 *********/
#import "JoinGroupRequst.h"
@interface JoinGroupRequst()<AFNetworkRequestDatasource>

@end
@implementation JoinGroupRequst
-(void)JoinGroupRequstWithgroupId :(NSString *)groupId withuserId :(NSString *)userId :(JoinGroupBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"JoinGroup",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"groupId":groupId,
                                 @"userId":userId};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"加入圈子group%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{

    return APIurl;
}
@end
