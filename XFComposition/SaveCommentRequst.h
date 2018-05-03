//
//  SaveCommentRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SaveCommentBlock)(NSDictionary *);
@interface SaveCommentRequst : NSObject
-(void)SaveCommentRequstwithtitleId :(NSString *)titleId withuserId :(NSString *)userId withtypeFlag :(NSString *)typeFlag withcommentInfo :(NSString *)commentInfo :(SaveCommentBlock)block;
@end
