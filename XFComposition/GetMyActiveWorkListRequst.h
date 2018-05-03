//
//  GetMyActiveWorkListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetMyActiveWorkListBlock)(NSDictionary *);
@interface GetMyActiveWorkListRequst : NSObject
-(void)GetMyActiveWorkListRequstWithuserId :(NSString *)userId withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withworkName :(NSString *)workName withactiveId :(NSString *)activeId withactiveItemId :(NSString *)activeItemId withwriteStatic :(NSString *)writeStatic withwriteTypeId :(NSString *)writeTypeId :(GetMyActiveWorkListBlock)block;
@end
