//
//  BaseRequest.h
//  FenghuangFM
//
//  Created by tom555cat on 2016/11/14.
//  Copyright © 2016年 Hello World Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTTPType) {
    HTTPTypeGET,
    HTTPTypePOST,
};


typedef void(^HTTPRequestCompletion)(id responseObject, NSString *message, BOOL success);


///成功回调
typedef void (^SuccessedBlock)(NSDictionary *succeedResult);

///失败回调
typedef void (^FailedBlock)(NSURLSessionDataTask * __unused task, NSError *error);
@interface BaseRequest : NSObject

/**
 *  设置请求地址
 */
+ (instancetype)requestWithURL:(NSString *)url;

/**
 *  发送网络请求
 *  @param methodType 请求方式 GET POST
 *  @param params     传入参数
 *  @param completion 完成请求回调
 */
//- (NSURLSessionDataTask *)startWithMethod:(HTTPType)methodType
//                                   params:(id)params
//                               completion:(HTTPRequestCompletion)completion;

- (NSURLSessionDataTask *)startWithMethod:(HTTPType)methodType
                                   params:(id)params
                           successedBlock:(SuccessedBlock)success
                              failedBolck:(FailedBlock)failed;


// XML解析
- (void)startWithXMLParams:(id)params
              successedBlock:(SuccessedBlock)success
                 failedBolck:(FailedBlock)failed;
@end
