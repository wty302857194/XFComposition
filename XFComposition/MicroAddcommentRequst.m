//
//  MicroAddcommentRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*******
 添加段落接口
 
 ********/
#import "MicroAddcommentRequst.h"

@interface MicroAddcommentRequst ()<AFNetworkRequestDatasource>
@end
@implementation MicroAddcommentRequst
-(void)GetMricoAddpianduanrequsWithNoticeName :(NSString *)name withNoticeObject:(NSString *)noticeObject withNoticeContment:(NSString *)NoticeContent withNoticeId :(NSString *)NoticeID withUserId:(NSString *)userid :(GetMricoAddpianduanrequst)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"AddBlog",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"NoticeName":name,
                                 @"NoticeObject":noticeObject,
                                 @"NoticeContent":NoticeContent,
                                 @"NoticeID":NoticeID ,
                                 @"userid":userid,
                                 @"model":@"5"};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
//        NSLog(@"%@",responseObject[@"ret_msg"]);
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
