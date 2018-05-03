//
//  GetBookDongTaiRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/********
 获取学生教师读书分享
 ********/
#import "GetBookDongTaiRequst.h"
@interface GetBookDongTaiRequst()<AFNetworkRequestDatasource>

@end
@implementation GetBookDongTaiRequst
-(void)GetBookDongTaiRequst :(NSString *)bookid withflag :(NSString *)flag withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize :(GetBookDongTaiblcok)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetBookDongTai",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"bookid":bookid,
                                 @"flag":flag,
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize
                                 };
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        
        block(responseObject);
//        NSLog(@"获取学生教师读书分享%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
