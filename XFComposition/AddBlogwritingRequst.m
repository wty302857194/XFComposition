//
//  AddBlogwritingRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 添加文章 习作书写
 *****/
#import "AddBlogwritingRequst.h"
@interface AddBlogwritingRequst()<AFNetworkRequestDatasource>

@end
@implementation AddBlogwritingRequst
-(void)AddBlogwritingRequstwithNoticeName :(NSString *)NoticeName withNoticeObject :(NSString *)NoticeObject withNoticeContent :(NSString *)NoticeContent withNoticeID :(NSString *)NoticeID withuserid :(NSString *)userid withmodel :(NSString *)model withposttype :(NSString *)posttype withIsApp :(NSString *)IsApp :(AddBlogwritingBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"AddBlog",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"NoticeName":NoticeName,
                                 @"NoticeObject":NoticeObject,
                                 @"NoticeContent":NoticeContent,
                                 @"NoticeID":NoticeID,
                                 @"userid":userid,
                                 @"model":model,
                                 @"posttype":posttype,
                                 @"IsApp":IsApp
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"添加文章 习作书写%@",responseObject);
        
        
    }];
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
