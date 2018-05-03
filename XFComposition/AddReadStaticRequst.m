//
//  AddReadStaticRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/********
 标记图书的阅读状态
 ********/
#import "AddReadStaticRequst.h"
@interface AddReadStaticRequst()<AFNetworkRequestDatasource>

@end
@implementation AddReadStaticRequst
-(void)AddReadStaticRequstwithbookid :(NSString *)bookid withflag :(NSString *)flag withuserid :(NSString *)userid :(AddReadStaticblcok)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"AddReadStatic",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"bookid":bookid,
                                 @"userid":userid,
                                 @"flag":flag
                                 };
    
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        
        
        block(responseObject);
        NSLog(@"标记图书的阅读状态%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
