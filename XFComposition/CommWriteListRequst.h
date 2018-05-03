//
//  CommWriteListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetwiritlistRequst)(NSDictionary *);
@interface CommWriteListRequst : NSObject
-(void)Comm_GetWriteListrequstWithindex :(NSNumber *)pageIndex withpagesiz:(NSString *)pagesize withgradid:(NSString *)gardeID withtypeid:(NSString *)typeID withishot:(NSString *)ishost withtuijian:(NSString *)istuijian withlabelid:(NSString *)labelId withkeword:(NSString *)keyWord  BlogStatic :(NSString *)BlogStatic :(GetwiritlistRequst)block;
@end
