//
//  HomeGroupRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/4.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*******
 
 圈子
 ********/
#import "HomeGroupRequst.h"
#import "GroupModel.h"
@interface HomeGroupRequst ()<AFNetworkRequestDatasource>
@property (nonatomic,strong)NSMutableArray *array;

@end
@implementation HomeGroupRequst

-(NSMutableArray *)array{
    if (!_array) {
        _array = [[NSMutableArray alloc]init];
    }
    return _array;
}
-(void)HomeGetGroupInfo:(getGroupRequst)block{
    AFNetworkRequest *requst =[[AFNetworkRequest alloc]init];
    requst.datasource = self;
    NSDictionary *parameters = @{@"Action":@"GetGroupList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"typeId":@"0",
                                 @"GroupStatic":@"1",
                                 @"PageIndex":@"1",
                                 @"PageSize":@"2",
                                 @"isTuijian":@"0",
                                 @"isHost":@"0",
                                 @"keyWord":@""};
    [requst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
    
                [self.array removeAllObjects];
                for (NSDictionary *dic in responseObject[@"ret_data"][@"pageInfo"]) {
                    GroupModel *model = [GroupModel loadWithJSOn:dic];
                    [self.array addObject:model];
                }
                block(self.array);
                
 
    }];


}

-(NSString *)NetworkRequestBaseURLString{
    return APIurl;
}
@end
