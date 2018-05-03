//
//  GetWritePicRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetWritePicBlock)(NSDictionary *);
@interface GetWritePicRequst : NSObject
-(void)GetWritePicRequstwithblogid :(NSString *)blogid :(GetWritePicBlock)block;
@end
