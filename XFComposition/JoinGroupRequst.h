//
//  JoinGroupRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/22.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^JoinGroupBlock)(NSDictionary *);
@interface JoinGroupRequst : NSObject
-(void)JoinGroupRequstWithgroupId :(NSString *)groupId withuserId :(NSString *)userId :(JoinGroupBlock)block;
@end
