//
//  NSString+LCAdd.m
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/28.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import "NSString+LCAdd.h"

@implementation NSString (LCAdd)

+ (NSString *)lc_handleNil:(NSString *)string {
    if (!string ||
        string == nil ||
        [string isKindOfClass:[NSNull class]] ||
        [string isEqual:[NSNull null]]) {
        
        return @"";
    }
    return string;
}

@end


@implementation NSAttributedString (LCAdd)

+ (NSMutableAttributedString *)lc_attributedString:(NSDictionary *)attributesDic
                                              text:(NSString *)string {
    string = [NSString lc_handleNil:string];
    NSMutableAttributedString *retString = [[NSMutableAttributedString alloc]initWithString:string];
    [retString setAttributes:attributesDic range:NSMakeRange(0, string.length)];
    return retString;
}

NSMutableAttributedString* hyperLink (NSString *text) {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString lc_handleNil:text]];
    //    [str addAttribute:NSFontAttributeName value:kFontContent range:NSMakeRange(0, str.length)];
    //    [str addAttribute:NSForegroundColorAttributeName value:[AppSkin appDarkGreenColor] range:NSMakeRange(0, str.length)];
    //    [str addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleDouble) range:NSMakeRange(0, str.length)];
    return str;
}
@end
