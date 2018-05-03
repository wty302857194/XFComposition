//
//  SaveTitleRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 发布话题
 *****/
#import "SaveTitleRequst.h"
@interface SaveTitleRequst()<AFNetworkRequestDatasource>
@end

@implementation SaveTitleRequst
-(void)SaveTitleRequstwithtitleId :(NSString *)titleId withgroupId :(NSString *)groupId withpostType :(NSString *)postType withtitleContent :(NSString *)titleContent withtitle :(NSString *)title withuserId :(NSString *)userId :(SaveTitleBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"SaveTitle",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"titleId":titleId,
                                 @"groupId":groupId,
                                 @"postType":postType,
                                 @"titleContent":titleContent,
                                 @"title":title,
                                 @"userId":userId
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"发布话题%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
