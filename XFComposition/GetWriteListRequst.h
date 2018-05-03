//
//  GetWriteListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetWriteListBlock)(NSDictionary *);
@interface GetWriteListRequst : NSObject
-(void)GetWriteListRequstWithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withuserid :(NSString *)userid withtypeid :(NSString *)typeID withgardeId :(NSString *)gardeId withishost :(NSString *)ishost withistuijian :(NSString *)istuijian withlabelid :(NSString *)labelid withkeyword :(NSString *)keyword BlogStatic:(NSString *)BlogStatic :(GetWriteListBlock)block;
@end
