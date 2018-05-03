//
//  MyMicroRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^MyMicroBlock)(NSDictionary *);
@interface MyMicroRequst : NSObject
-(void)MyMicroRequstWithuserid :(NSString *)userid withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize :(MyMicroBlock)block;
@end
