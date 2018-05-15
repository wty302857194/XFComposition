//
//  BaseRequest.m
//  FenghuangFM
//
//  Created by tom555cat on 2016/11/14.
//  Copyright © 2016年 Hello World Corporation. All rights reserved.
//

#import "BaseRequest.h"


@interface BaseRequest ()

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, copy) HTTPRequestCompletion completionBlock;

@property (nonatomic, strong) AFHTTPSessionManager    *sessionManager;

@end

@implementation BaseRequest

/**
 *  设置请求地址
 */
+ (instancetype)requestWithURL:(NSString *)url {
    BaseRequest *request = [[BaseRequest alloc] init];
    request.urlString = APIurl;
    return request;
}

/**
 *  发送网络请求
 *  @param methodType 请求方式 GET POST
 *  @param params     传入参数
 *  @param success 完成请求回调
 */
- (NSURLSessionDataTask *)startWithMethod:(HTTPType)methodType
                                   params:(id)params
                           successedBlock:(SuccessedBlock)success
                              failedBolck:(FailedBlock)failed {
    NSURLSessionDataTask *task = nil;
//    self.completionBlock = completion;
//    self.sessionManager = [self sessionManagerWithParams];
    NSString *temUrl = [self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    if(methodType == HTTPTypeGET) {
        task = [self.sessionManager GET:temUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failed) {
                failed(task,error);
            }
        }];
    } else if(methodType == HTTPTypePOST) {
        task = [self.sessionManager POST:temUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failed) {
                failed(task,error);
            }
        }];
    }
    return nil;
}

- (void)startWithXMLParams:(id)params
                           successedBlock:(SuccessedBlock)success
                                 failedBolck:(FailedBlock)failed {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 直接使用“服务器本来返回的数据”，不做任何解析
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [AFXMLParserResponseSerializer serializer]; // 解析服务器返回的XML数据
    NSString *temUrl = [self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    [mgr POST:temUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failed) {
            failed(task,error);
        }
        
    }];
}
- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 30.0f;
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
    }
    return _sessionManager;
}

//- (AFHTTPSessionManager *)sessionManagerWithParams{
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    config.timeoutIntervalForRequest = 30.0f;
//    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
//    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
////    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
////    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    return sessionManager;
//}


@end
