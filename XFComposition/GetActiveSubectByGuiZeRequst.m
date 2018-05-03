//
//  GetActiveSubectByGuiZeRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetActiveSubectByGuiZeRequst.h"
/****
 获取图书活动的自动组卷的题目规则
 ****/
@interface GetActiveSubectByGuiZeRequst()<AFNetworkRequestDatasource>

@end
@implementation GetActiveSubectByGuiZeRequst
-(void)GetActiveSubectByGuiZeRequstwithDanXuanSubjectNum :(NSString *)DanXuanSubjectNum withDuoXuanSubjectNum :(NSString *)DuoXuanSubjectNum withPanDuanSubjectNum :(NSString *)PanDuanSubjectNum withTianKongSubjectNum :(NSString *)TianKongSubjectNum withWenDaSubjectNum :(NSString *)WenDaSubjectNum withActiveID :(NSString *)ActiveID withuserid :(NSString *)userid :(GetActiveSubectByGuiZeBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetActiveSubectByGuiZe",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"DanXuanSubjectNum":DanXuanSubjectNum,
                                 @"DuoXuanSubjectNum":DuoXuanSubjectNum,
                                 @"PanDuanSubjectNum":PanDuanSubjectNum,
                                 @"TianKongSubjectNum":TianKongSubjectNum,
                                 @"WenDaSubjectNum":WenDaSubjectNum,
                                 @"ActiveID":ActiveID,
                                 @"userid":userid
                                 
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
//        NSLog(@"获取图书活动的自动组卷的题目规则%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
