//
//  AddBlogPicReuqst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 手机版添加文章图
 ******/
#import "AddBlogPicReuqst.h"
@interface AddBlogPicReuqst()<AFNetworkRequestDatasource>

@end
@implementation AddBlogPicReuqst
-(void)AddBlogPicReuqstwithblogID :(NSString *)blogID withblogPic :(NSString *)blogPic withuserid :(NSString *)userid :(AddBlogPicBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"AddBlogPic",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"blogID":blogID,
                                 @"blogPic":blogPic,
                                 @"userid":userid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"手机版添加文章图%@",responseObject);
        
        
    }];

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
