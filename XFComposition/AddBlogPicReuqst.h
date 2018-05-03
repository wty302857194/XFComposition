//
//  AddBlogPicReuqst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^AddBlogPicBlock)(NSDictionary *);
@interface AddBlogPicReuqst : NSObject
-(void)AddBlogPicReuqstwithblogID :(NSString *)blogID withblogPic :(NSString *)blogPic withuserid :(NSString *)userid :(AddBlogPicBlock)block;
@end
