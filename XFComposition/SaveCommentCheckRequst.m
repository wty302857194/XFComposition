//
//  SaveCommentCheckRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/******
 手机版添加点评内容
 ******/
#import "SaveCommentCheckRequst.h"
@interface SaveCommentCheckRequst()<AFNetworkRequestDatasource>

@end
@implementation SaveCommentCheckRequst
-(void)SaveCommentCheckRequstWithRemarkID :(NSString *)RemarkID withRemark :(NSString *)Remark withuserid :(NSString *)userid withblogPicID :(NSString *)blogPicID withXLocation :(NSString *)XLocation withYLocation :(NSString *)YLocation :(SaveCommentCheckBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"SaveCommentCheck",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"RemarkID":RemarkID,
                                 @"Remark":Remark,
                                 @"userid":userid,
                                 @"blogPicID":blogPicID,
                                 @"XLocation":XLocation,
                                 @"YLocation":YLocation
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@" 手机版添加点评内容%@",responseObject);
        
        
    }];

}
- (void)XFUpdateBlogPic:(NSString *)imgid fixpic:(NSString *)fixpic :(SaveCommentCheckBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"UpdateBlogPic",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"ImgId":imgid,
                                 @"FixPic":fixpic,
                               
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        //        NSLog(@" 手机版添加点评内容%@",responseObject);
        
        
    }];
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
