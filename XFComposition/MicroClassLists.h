//
//  MicroClassLists.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^micLists)(NSDictionary *);
@interface MicroClassLists : NSObject
-(void)GetmicrListWith :(NSString *)Fristparameter :(NSString *)Secondeparameters :(NSString *)Thridparameters :(micLists)block;
@end
