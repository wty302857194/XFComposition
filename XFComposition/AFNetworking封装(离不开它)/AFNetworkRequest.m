//
//  JDNetworkRequest.m
//  AF封装
//
//  Created by 张泽楠 on 15/11/15.
//  Copyright © 2015年 张泽楠. All rights reserved.
//

#import "AFNetworkRequest.h"
#import "AFNetworking.h"
@import CoreTelephony;

@interface AFNetworkRequest ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, assign, getter=isConnected) BOOL connected;/**<网络是否连接*/
 
@end

@implementation AFNetworkRequest

- (NSURLSessionDataTask *)requestWithURLString:(NSString *)urlString
                  parameters:(NSDictionary *)parameters
                        type:(NetworkRequestType)type
                     imgData:(NSArray *)imgData
                 resultBlock:(NetworkRequestResultBlock)resultBlock {
           
    if (!self.isConnected) {
        CTCellularData *cellularData = [[CTCellularData alloc]init];
        cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
            //获取联网权限状态
            switch (state) {
                case kCTCellularDataRestricted:
                {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"该应用目前没有移动网络权限,请去\"设置\"中打开移动网络权限." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                        alert.delegate=self;
//                        
//                        [alert show];
//                        
//                    });
                    
                    
                }
                    break;
                case kCTCellularDataNotRestricted:
                {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"没有网络,建议在手机设置中打开网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                        [alert show];
//                    });
                    
                    
                }
                    
                    break;
                case kCTCellularDataRestrictedStateUnknown:
                    NSLog(@"Unknown");
                    break;
                default:
                    break;
            };
        };
        
        
        return nil;
    }
    if (![self.datasource respondsToSelector:@selector(NetworkRequestBaseURLString)]) {
        NSLog(@"error:未实现JDNetworkRequestDatasource");
        return nil;
    }
    NSSet *acceptableContentTypes = [NSSet setWithObjects:
                                     @"application/json",
                                     @"text/html",
                                      @"image/jpeg",
                                      @"image/png",
                                     @"text/json",
                                    @"application/octet-stream",
                                     @"text/javascript",
                                     @"text/plain",
                                     @"application/x-javascript", nil];
    
    self.manager.responseSerializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    self.manager.operationQueue.maxConcurrentOperationCount = 5;
    self.manager.requestSerializer.timeoutInterval = 8.0;
    self.manager.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    [self.manager.requestSerializer setValue:@"native_iOS" forHTTPHeaderField:@"User-Agent"];
    
    
    switch (type) {
        case NetworkRequestTypePost: {
            
    NSURLSessionDataTask *task= [self.manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
              
          } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              [self handleRequestResultWithDataTask:task responseObject:responseObject
                                              error:nil
                                        resultBlock:resultBlock];
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
              
              [self handleRequestResultWithDataTask:task responseObject:nil
                                              error:error
                                        resultBlock:resultBlock];

          }];
            
        return task;
            
            
//            [self.manager POST:urlString
//                    parameters:parameters
//                       success:^(NSURLSessionDataTask *task, id responseObject) {
//                           [self handleRequestResultWithDataTask:task
//                                                  responseObject:responseObject
//                                                           error:nil
//                                                     resultBlock:resultBlock];
//                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                           [self handleRequestResultWithDataTask:task
//                                                  responseObject:nil
//                                                           error:error
//                                                     resultBlock:resultBlock];
//                       }];
//            break;
        }
        case NetworkRequestTypePostImg: {
            
            [self.manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                NSData *image = imgData[0];
               
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
           
          
                
                [formData appendPartWithFileData:image name:@"userfile" fileName:fileName mimeType:@"image/jpeg"];
                
          
                
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestResultWithDataTask:task responseObject:responseObject
                                                error:nil
                                          resultBlock:resultBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [self handleRequestResultWithDataTask:task responseObject:nil
                                                error:error
                                          resultBlock:resultBlock];
            }];
            
            break;
        }
   
            
            
            
        case NetworkRequestTypeGet: {
            
            [self.manager GET: urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                
                
            [self handleRequestResultWithDataTask:task
                                       responseObject:responseObject
                                                error:nil
                                          resultBlock:resultBlock];
                
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              //  NSLog(@"%@",error);
                [self handleRequestResultWithDataTask:task
                                       responseObject:nil
                                                error:error
                                          resultBlock:resultBlock];

            }];
            
            
//            [self.manager GET:urlString
//                   parameters:parameters
//                      success:^(NSURLSessionDataTask *task, id responseObject) {
//                          [self handleRequestResultWithDataTask:task
//                                                 responseObject:responseObject
//                                                          error:nil
//                                                    resultBlock:resultBlock];
//                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                          [self handleRequestResultWithDataTask:task
//                                                 responseObject:nil
//                                                          error:error
//                                                    resultBlock:resultBlock];
//                      }];
            break;
        }
        case NetworkRequestTypePut: {
            
        
            
            [self.manager PUT:urlString
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [self handleRequestResultWithDataTask:task
                                                 responseObject:responseObject
                                                          error:nil
                                                    resultBlock:resultBlock];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          [self handleRequestResultWithDataTask:task
                                                 responseObject:nil
                                                          error:error
                                                    resultBlock:resultBlock];
                      }];
            break;
        }
        case NetworkRequestTypeHead: {
            [self.manager HEAD:urlString
                    parameters:parameters
                       success:^(NSURLSessionDataTask *task) {
                           [self handleRequestResultWithDataTask:task
                                                  responseObject:nil
                                                           error:nil
                                                     resultBlock:resultBlock];
                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                           [self handleRequestResultWithDataTask:task
                                                  responseObject:nil
                                                           error:error
                                                     resultBlock:resultBlock];
                       }];
            break;
        }
        case NetworkRequestTypeDelete:{
            [self.manager DELETE:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
                [self handleRequestResultWithDataTask:task
                                       responseObject:nil
                                                error:nil
                                          resultBlock:resultBlock];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [self handleRequestResultWithDataTask:task
                                       responseObject:nil
                                                error:error
                                          resultBlock:resultBlock];
            }];
            break;
        }
    }
    return nil;
}

- (BOOL)isConnected {
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}


- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        NSString *baseUrlString = [self.datasource NetworkRequestBaseURLString];
        _manager = [[AFHTTPSessionManager alloc]
                    initWithBaseURL:[NSURL URLWithString:baseUrlString]];
    }
    return _manager;
}

- (void)handleRequestResultWithDataTask:(NSURLSessionDataTask *)task
                         responseObject:(id)responseObject
                                  error:(NSError *)error
                            resultBlock:(NetworkRequestResultBlock)resultBlock {
    //do something here...
   
    if(resultBlock) {
        
        resultBlock(responseObject,error,task);

    }
}
 
 @end
