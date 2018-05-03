//
//  NSString+LCAdd.h
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/28.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PNDEAL(text)  [NSString lc_handleNil:text]

@interface NSString (LCAdd)

+ (NSString *)lc_handleNil:(NSString *)string;

@end


@interface NSAttributedString (LCAdd)
+ (NSMutableAttributedString *)lc_attributedString:(NSDictionary *)attributesDic text:(NSString *)string;

@end
