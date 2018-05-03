//
//  HomeGetMicroClassRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/4.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^microClassRequst)(NSDictionary *);

@interface HomeGetMicroClassRequst : NSObject
-(void)HomeGetMicroclass :(microClassRequst)block;
@end
