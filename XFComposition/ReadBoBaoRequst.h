//
//  ReadBoBaoRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ReadBoBaoblcok)(NSDictionary *);
@interface ReadBoBaoRequst : NSObject
-(void)ReadBoBaoRequstWithPageIndex :(NSString *)PageIndex withPageSize :(NSString *)PageSize withflag :(NSString *)flag withistuijian :(NSString *)istuijian :(ReadBoBaoblcok)block;
@end
