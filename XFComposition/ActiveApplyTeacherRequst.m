//
//  ActiveApplyTeacherRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ActiveApplyTeacherRequst.h"
@interface ActiveApplyTeacherRequst()<AFNetworkRequestDatasource>

@end
@implementation ActiveApplyTeacherRequst
-(void)GetActiveApplyTeacherListWithPageIndex :(NSString *)index withPagesize :(NSString *)pagesize withactiveID :(NSString *)activeId withteacherstatic :(NSInteger)teacherstatic :(GetActiveApplyTeacherList)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    NSDictionary *parameters = @{@"Action":@"GetActiveApplyTeacherList",@"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",@"PageIndex":index,@"PageSize":pagesize,@"activeid":activeId,@"teacherstatic":[NSString stringWithFormat:@"%ld",(long)teacherstatic]};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        block(responseObject);
        NSLog(@"---%@",responseObject);
        
        
    }];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
