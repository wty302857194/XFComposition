//
//  GetActiveWriteList.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetActiveWriteListRequst)(NSDictionary *);
@interface GetActiveWriteList : NSObject

-(void)GetActiveWriteListWithActId :(NSString *)actId withProductionName :(NSString *)ProductionName withActiveItem: (NSString *)ActiveItem withWriteStatic :(NSString *)WriteStatic withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withWriteTypeID :(NSString *)WriteTypeID withGroupID:(NSString *)GroupID :(GetActiveWriteListRequst)block;
@end
