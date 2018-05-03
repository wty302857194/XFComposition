//
//  GetCommentListRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/9.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetCommentListBlock)(NSDictionary *);
@interface GetCommentListRequst : NSObject
-(void)GetCommentListRequstWithclassId :(NSString *)classId withmodelId :(NSString *)modelId withPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize :(GetCommentListBlock)block;
@end
