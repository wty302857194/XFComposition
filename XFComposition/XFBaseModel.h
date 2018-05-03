//
//  XFBaseModel.h
//  XFComposition
//
//  Created by 笨笨编程 on 2017/9/15.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFBaseModel : NSObject

/**
 *  ret_code
 */
@property (assign, nonatomic) NSInteger ret_code;

/**
 *  ret_msg
 */
@property (strong, nonatomic) NSString *ret_msg;

@end
