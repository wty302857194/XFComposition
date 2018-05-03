//
//  GetBookPaiHangRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetBookPaiHangblcok)(NSDictionary *);
@interface GetBookPaiHangRequst : NSObject
-(void)GetBookPaiHangRequstWithflag :(NSString *)flag :(GetBookPaiHangblcok)block;
@end
