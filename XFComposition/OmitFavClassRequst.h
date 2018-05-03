//
//  OmitFavClassRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^OmitFavClassBlock)(NSDictionary *);
@interface OmitFavClassRequst : NSObject
-(void)OmitFavClassRequstWithclassID :(NSString *)classID  withuserid:(NSString *)userid :(OmitFavClassBlock)block;
@end
