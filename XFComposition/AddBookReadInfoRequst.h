//
//  AddBookReadInfoRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^AddBookReadInfoblcok)(NSDictionary *);
@interface AddBookReadInfoRequst : NSObject
-(void)AddBookReadInfoRequstWithBookId :(NSString *)BookId withCurrentReadNum :(NSString *)CurrentReadNum withContentTag :(NSString *)ContentTag withContent :(NSString *)Content withuserid :(NSString *)userid :(AddBookReadInfoblcok)block;
@end
