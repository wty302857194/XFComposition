//
//  VolunteerRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*******
 志愿者活动
 ********/
#import "VolunteerRequst.h"
@interface VolunteerRequst ()<AFNetworkRequestDatasource>

@end
@implementation VolunteerRequst

-(void)GetVolunteerRequstWithpagesize :(NSInteger )index :(NSString *)pagesize WithAcitivieTypeID:(NSString *)type :(Volunteerrequst)block{
//    [SVProgressHUD showWithStatus:@"正在加载..."];
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetReadActive",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":[NSString stringWithFormat:@"%ld",(long)index],
                                 @"PageSize":pagesize,
                                 @"keyword":@"",
                                 @"ActiveTypeID":type};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        block(responseObject);
//        [SVProgressHUD dismiss];
        //                NSLog(@"志愿者活动%@",responseObject);
        
    }];


}
- (void)GetBlogHaojuWithBlogid:(NSInteger)blogid :(Volunteerrequst)block{
    
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    NSDictionary *parameters = @{@"Action":@"GetBlogHaoju",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"blogid":[NSString stringWithFormat:@"%ld",blogid],
                              
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        block(responseObject);
        //        [SVProgressHUD dismiss];
        //                NSLog(@"志愿者活动%@",responseObject);
        
    }];
}

- (void)GetNewsList:(Volunteerrequst)block{
    
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    NSDictionary *parameters = @{@"Action":@"GetNewsList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":@"1",
                                 @"PageSize":@"3"
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        block(responseObject);
        //        [SVProgressHUD dismiss];
        //                NSLog(@"志愿者活动%@",responseObject);
        
    }];
}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
