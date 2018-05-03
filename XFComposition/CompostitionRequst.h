//
//  CompostitionRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/5.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^writelistRequst)(NSDictionary *);
@interface CompostitionRequst : NSObject
-(void)GetWriteList:(NSString *)pagesize :(writelistRequst)block;
@end
