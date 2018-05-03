//
//  MicroClassTypeRquset.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetmicrClass)(NSDictionary *);
@interface MicroClassTypeRquset : NSObject
-(void)GetmicrTypeWith :(NSString *)changeId :(GetmicrClass)block;
@end
