//
//  SaveMypageRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/27.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 保存教师的组卷
 *****/
#import "SaveMypageRequst.h"
@interface SaveMypageRequst()<AFNetworkRequestDatasource>

@end
@implementation SaveMypageRequst
-(void)SaveMypageRequstwithpagename :(NSString *)pagename withpagesocre :(NSString *)pagesocre withpageinfo :(NSString *)pageinfo withactiveid :(NSString *)activeid withpagetime :(NSString *)pagetime withsubjectids :(NSString *)subjectids withpageoksocer :(NSString *)pageoksocer withuserid :(NSString *)userid :(SaveMypageBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"SaveMypage",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"pagename":pagename,
                                 @"pagesocre":pagesocre,
                                 @"pageinfo":pageinfo,
                                 @"activeid":activeid,
                                 @"pagetime":pagetime,
                                 @"subjectids":subjectids,
                                 @"pageoksocer":pageoksocer,
                                 @"userid":userid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"保存教师的组卷%@",responseObject);
        
        
    }];
    
    
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
    
}
@end
