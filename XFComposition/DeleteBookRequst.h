//
//  DeleteBookRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^DeleteBookBlock)(NSDictionary *);
@interface DeleteBookRequst : NSObject
-(void)DeleteBookRequstWithbookids :(NSString *)bookids :(DeleteBookBlock)block;
@end
