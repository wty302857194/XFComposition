//
//  UploadPicRequst.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/19.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/*****
 上传照片
 *****/
#import "UploadPicRequst.h"
@interface UploadPicRequst()<AFNetworkRequestDatasource>

@end
@implementation UploadPicRequst
-(void)UploadPicRequstWithfileValue :(NSData *)imageData withuserid :(NSString *)userid withtypeid :(NSString *)typeID :(UploadPicBlock)block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters1 = @{@"Action":@"UploadPic",
                                  @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                                  @"userid":userid,
                                  @"typeid":typeID
                                  };
    NSURLSessionDataTask *task = [manager POST:@"http://xf.vqune.com/wsdl/AppService.ashx" parameters:parameters1 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"fileValue"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
//        NSLog(@"上传进度");
//        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //上传成功
        NSLog(@"上传成功");
//        NSLog(@"%@",responseObject);
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //上传失败
        NSLog(@"上传失败");
    }];
    [task resume];


}
-(NSString *)NetworkRequestBaseURLString{
    return APIurl;

}
@end
