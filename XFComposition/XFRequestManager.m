//
//  XFRequestManager.m
//  XFComposition
//
//  Created by qiannian on 2018/5/4.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "XFRequestManager.h"
#import "MessageDetail.h"

static XFRequestManager *instance = nil;

@interface XFRequestManager()<AFNetworkRequestDatasource>

@end;

@implementation XFRequestManager
@synthesize xfrequst;
+ (XFRequestManager *)sharedInstance {
    if (!instance) {
        @synchronized(self){
            if (!instance) {
                instance = [[self alloc] init];
              

            }
        }
    }
    
    return instance;
}
-(instancetype)init{
    
    
    if (self = [super init]) {
        xfrequst =[[AFNetworkRequest alloc]init];
        xfrequst.datasource = self;
    }
    return self;
    
}
-(void)XFRequstGetMessageDetail:(NSString *)MsgId userid:(NSString *)userid repondeBlock:(XFResponseBlock)block{
    
    NSDictionary *parameters = @{@"Action":@"GetDetail",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userid,
                                 @"MsgId":MsgId,
                                 };
    [self printUrl:_requestName parameters:parameters];
    [xfrequst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        if ([responseObject[@"ret_code"] integerValue] == 0) {
            NSMutableArray  * array= [FMBean objectsWithArray:responseObject[@"ret_data"] classType:[MessageDetail class]];
            block(XFReq_User_getMessageDetail, array ,YES);
        }else{
            
            NSString *msg = responseObject[@"ret_msg"];
            block(XFReq_User_getMessageDetail, msg,NO);
        }
      
        
        
        
    }];

    
    
}
-(void)XFRequstsetMessageRed:(NSString *)MsgId userid:(NSString *)userid repondeBlock:(XFResponseBlock)block{
    
    NSDictionary *parameters = @{@"Action":@"SetMessageLook",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"userid":userid,
                                 @"MsgId":MsgId,
                                 };
    [self printUrl:_requestName parameters:parameters];
    [xfrequst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        if ([responseObject[@"ret_code"] integerValue] == 0) {
            NSString *msg = responseObject[@"ret_msg"];

            block(XFReq_User_getMessageDetail, msg ,YES);
        }else{
            
            NSString *msg = responseObject[@"ret_msg"];
            block(XFReq_User_getMessageDetail, msg,NO);
        }
        
        
        
        
    }];

    
}
-(void)XFRequstGetMessageList:(NSString *)PageIndex withPageSize :(NSString *)PageSize withtype :(NSString *)type withflag :(NSString *)flag withuserid :(NSString *)userid :(XFResponseBlock)block{

    NSDictionary *parameters = @{@"Action":@"GetMessageList",
                                 @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                 @"PageIndex":PageIndex,
                                 @"PageSize":PageSize,
                                 @"type":type,
                                 @"flag":flag,
                                 @"userid":userid
                                 };
    
    
    [xfrequst requestWithURLString:APIurl parameters:parameters type:NetworkRequestTypePost imgData:nil resultBlock:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        NSLog(@"我的消息%@",responseObject);
        if ([responseObject[@"ret_code"] integerValue] == 0) {

            NSMutableArray * array =  [FMBean objectsWithArray:responseObject[@"ret_data"][@"pageInfo"] classType:[GetMessageListModel class]];
            block(XFReq_User_getMessageDetail, array ,YES);
        }else{
            
            NSString *msg = responseObject[@"ret_msg"];
            block(XFReq_User_getMessageDetail, msg,NO);
        }
        
        
    }];
    
    
}
-(void)printUrl:(NSString*)requstName parameters:(NSDictionary*)parameters{
    
    
    NSLog(@"[%@]:%@?%@",requstName,APIurl,[XFRequestManager encodedParams:parameters]);

    
}
+(NSString*)encodedParams:(NSDictionary*)params
{
    NSMutableString *ms = [NSMutableString stringWithCapacity:100];
    
    NSArray *keys = [params allKeys];
    for (int i=0; i<keys.count; i++)
    {
        NSString *k = [keys objectAtIndex:i];
        NSString *value = [NSString stringWithFormat:@"%@", [params objectForKey:k]];
        if (i != 0) {
            [ms appendString:@"&"];
        }
        
        [ms appendFormat:@"%@=%@", k, value];
    }
    
    return [ms stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
- (NSString *)NetworkRequestBaseURLString {
     return APIurl;
}

@end