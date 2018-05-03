//
//  GetMyHtListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetMyHtListBlock)(NSDictionary *);
@interface GetMyHtListRequst : NSObject
-(void)GetMyHtListRequstWithtypeId :(NSString *)typeId withgroupId :(NSString *)groupId withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withflag :(NSString *)flag withkeyWord :(NSString *)keyWord :(GetMyHtListBlock)block;
@end
