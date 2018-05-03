//
//  GetTitleCommentRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/1.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetTitleCommentBlock)(NSDictionary *);
@interface GetTitleCommentRequst : NSObject
-(void)GetTitleCommentRequstwithtitleId :(NSString *)titleId withmasterId :(NSString *)masterId withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withmasteOnly :(NSString *)masteOnly withorderFlag :(NSString *)orderFlag :(GetTitleCommentBlock)block;
@end
