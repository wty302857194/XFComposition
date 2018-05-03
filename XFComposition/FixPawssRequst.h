//
//  FixPawssRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^FixPawssBlock)(NSDictionary *);
@interface FixPawssRequst : NSObject
-(void)FixPawssRequstwithuserid :(NSString *)userid witholdpwd :(NSString *)oldpwd withnewpwd :(NSString *)newpwd :(FixPawssBlock)block;
@end
