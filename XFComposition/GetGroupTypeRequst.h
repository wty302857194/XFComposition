//
//  GetGroupTypeRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetGroupTypeBlock)(NSDictionary *);
@interface GetGroupTypeRequst : NSObject
-(void)GetGroupTypeRequstwith :(GetGroupTypeBlock)block;
@end
