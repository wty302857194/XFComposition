//
//  fixmyinfoRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^fixmyinfoBlock)(NSDictionary *);
@interface fixmyinfoRequst : NSObject
-(void)fixmyinfoRequstwithusername :(NSString *)username withusersex :(NSString *)usersex withusertype :(NSString *)usertype withuserguid :(NSString *)userguid withuserphone :(NSString *)userphone withuseremail :(NSString *)useremail withuserbrith :(NSString *)userbrith withqqnum :(NSString *)qqnum withclassid :(NSString *)classid withuserid :(NSString *)userid :(fixmyinfoBlock)block;
@end
