//
//  TeachApplyActionRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/********
 志愿者教师申请
 ********/
#import "TeachApplyActionRequst.h"
@interface TeachApplyActionRequst ()<AFNetworkRequestDatasource>

@end
@implementation TeachApplyActionRequst
-(void)TeachApplyActionWithUserId :(NSString *)userId withName :(NSString *)name withAge :(NSString *)age withSex :(NSString *)sex withPhone :(NSString *)phone withteacherpic :(NSString *)teacherpic withteachercardfond :(NSString *)teachercardfond withteachercardback :(NSString *)teachercardback withteachercertified :(NSString *)teachercertified withteacherworkcard :(NSString *)teacherworkcard withteacherapplytable1 :(NSString *)teacherapplytable1 withteacherapplytable2 :(NSString *)teacherapplytable2 withteacherinfo :(NSString *)teacherinfo :(TeachApplyAction)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"TeachApplyAction",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userId,
                                 @"name":name,
                                     @"age":age,
                                     @"sex":sex,
                                     @"phone":phone,
                                     @"teacherpic":teacherpic,
                                     @"teachercardfond":teachercardfond,
                                     @"teachercardback":teachercardback,
                                     @"teachercertified":teachercertified,
                                     @"teacherworkcard":teacherworkcard,
                                     @"teacherapplytable1":teacherapplytable1,
                                     @"teacherapplytable2":teacherapplytable2,
                                     @"teacherinfo":teacherinfo};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"志愿者教师申请%@",responseObject);
        
        
    }];

    

}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
