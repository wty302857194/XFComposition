//
//  TeacherApplyVolRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "TeacherApplyVolRequst.h"
@interface TeacherApplyVolRequst ()<AFNetworkRequestDatasource>

@end
@implementation TeacherApplyVolRequst
-(void)TeacherApplyVolRequstWithuserid:(NSString *)userid withWriteNum :(NSString *)WriteNum withActiveId :(NSString *)ActiveId withfirstSet :(NSString *)firstSet withjinji :(NSString *)jinji withfreeTime: (NSString *)freeTime :(TeacherApplyVolBlock)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"TeachApplyAction",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userid,
                                 @"WriteNum":WriteNum,
                                 @"ActiveId":ActiveId,
                                 @"firstSet":firstSet,
                                 @"jinji":jinji,
                                 @"freeTime":freeTime,
                                 };
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"---%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
