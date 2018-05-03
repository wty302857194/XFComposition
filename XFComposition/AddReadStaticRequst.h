//
//  AddReadStaticRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^AddReadStaticblcok)(NSDictionary *);
@interface AddReadStaticRequst : NSObject
-(void)AddReadStaticRequstwithbookid :(NSString *)bookid withflag :(NSString *)flag withuserid :(NSString *)userid :(AddReadStaticblcok)block;
@end
