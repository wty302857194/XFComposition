//
//  SaveGJRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/********
 保存作文
 ********/
#import "SaveGJRequst.h"
@interface SaveGJRequst()<AFNetworkRequestDatasource>

@end
@implementation SaveGJRequst
-(void)SaveGJRequstWithclassId :(NSString *)classID withModelld :(NSString *)modeleid withUserID :(NSString *)userid ids:(NSString *)ids   :(SaveGJBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"SaveGJ",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"classId":classID,
                                 @"modelId":modeleid ,
                                 @"userid":userid,
                                 @"ids":ids,
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
        
        NSLog(@"保存作文%@",responseObject);
        
        
    }];


}

-(void)PostTeacherWithclassId :(NSString *)classID withModelld :(NSString *)modeleid withUserID :(NSString *)userid  ids:(NSString *)ids  :(SaveGJBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"PostTeacher",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"classId":classID,
                                 @"modelId":modeleid ,
                                 @"userid":userid,
                                 @"ids":ids,
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        
        block(responseObject);
        
        NSLog(@"保存作文%@",responseObject);
        
        
    }];
    
    
}


-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
