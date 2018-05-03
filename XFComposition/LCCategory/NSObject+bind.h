//
//  NSObject+bind.h
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/27.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (bind)

@property (nonatomic, copy) NSString *lc_bindValue;
@property (nonatomic, copy) NSString *lc_detailValue;

@property (nonatomic, strong) id lc_bindObject;

@end
