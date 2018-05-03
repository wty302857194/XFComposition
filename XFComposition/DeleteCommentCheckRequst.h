//
//  DeleteCommentCheckRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/22.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^DeleteCommentCheckBlock)(NSDictionary *);
@interface DeleteCommentCheckRequst : NSObject
-(void)DeleteCommentCheckRequstwithRemarkID :(NSString *)RemarkID withuserid :(NSString *)userid :(DeleteCommentCheckBlock)block;
@end
