//
//  LoginRequest.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/1.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
typedef void (^requstBlock)(NSDictionary *);
@interface LoginRequest : NSObject

-(void)LoginRequstphoneText:(NSString *)phonetext password:(NSString *)passwor :(requstBlock)block;
@end
