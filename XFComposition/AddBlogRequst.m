//
//  AddBlogRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/29.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*********
 新建作文
 *********/
#import "AddBlogRequst.h"
@interface AddBlogRequst()<AFNetworkRequestDatasource>

@end
@implementation AddBlogRequst
-(void)AddBlogRequstWithNoticeName: (NSString *)noticeName withNoticeObject :(NSString *)noticeObject withNoticeContent :(NSString *)noticeContent withNoticeID :(NSString *)noticeID withuserid :(NSString *)userid withactiveItemId :(NSString *)activeItemId withposttype :(NSString *)posttype :(AddBlogBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"Addgj",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"NoticeName":noticeName,
                                 @"NoticeObject":noticeObject ,
                                 @"NoticeContent":noticeContent,
                                 @"NoticeID":noticeID,
                                 @"userid":userid,
                                 @"modelid":@"5"
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
        
//        NSLog(@"新建作文%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
