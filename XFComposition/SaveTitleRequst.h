//
//  SaveTitleRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SaveTitleBlock)(NSDictionary *);
@interface SaveTitleRequst : NSObject
-(void)SaveTitleRequstwithtitleId :(NSString *)titleId withgroupId :(NSString *)groupId withpostType :(NSString *)postType withtitleContent :(NSString *)titleContent withtitle :(NSString *)title withuserId :(NSString *)userId :(SaveTitleBlock)block;
@end
