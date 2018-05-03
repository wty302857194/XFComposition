//
//  SaveGJRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SaveGJBlock)(NSDictionary *);
@interface SaveGJRequst : NSObject
-(void)SaveGJRequstWithclassId :(NSString *)classID withModelld :(NSString *)modeleid withUserID :(NSString *)userid ids:(NSString *)ids  :(SaveGJBlock)block;

//提交老师
-(void)PostTeacherWithclassId :(NSString *)classID withModelld :(NSString *)modeleid withUserID :(NSString *)userid  ids:(NSString *)ids  :(SaveGJBlock)block;

@end
