//
//  GetGroupInfoRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetGroupInfoBlock)(NSDictionary *);
@interface GetGroupInfoRequst : NSObject
-(void)GetGroupInfoRequstWithgruopID :(NSString *)gruopID withuserid :(NSString *)userid :(GetGroupInfoBlock)block;
@end
