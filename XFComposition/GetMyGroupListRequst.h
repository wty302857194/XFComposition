//
//  GetMyGroupListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetMyGroupListBlock)(NSDictionary *);

@interface GetMyGroupListRequst : NSObject
-(void)GetMyGroupListRequstwithuserId :(NSString *)userId withtypeId :(NSString *)typeId withflag :(NSString *)flag withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withisTuijian :(NSString *)isTuijian withkeyWord :(NSString *)keyWord :(GetMyGroupListBlock)block;
@end
