//
//  CreateGroupRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CreateGroupBlock)(NSDictionary *);
@interface CreateGroupRequst : NSObject
-(void)CreateGroupRequstwithid :(NSString *)IFid withuserid :(NSString *)userid withgroupname :(NSString *)groupname withtypeid :(NSString *)typeID withgroupinfo :(NSString *)groupinfo withgroupicon :(NSString *)groupicon :(CreateGroupBlock)block;
@end
