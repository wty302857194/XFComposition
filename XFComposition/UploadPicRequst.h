//
//  UploadPicRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/19.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^UploadPicBlock)(NSDictionary *);
@interface UploadPicRequst : NSObject
-(void)UploadPicRequstWithfileValue :(NSData *)imageData withuserid :(NSString *)userid withtypeid :(NSString *)typeID :(UploadPicBlock)block;
@end
