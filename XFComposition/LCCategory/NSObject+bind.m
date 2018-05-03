//
//  NSObject+bind.m
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/27.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import "NSObject+bind.h"

@implementation NSObject (bind)

const void *__bindValue = @"__lc_bindValue";
const void *__detailValue = @"__lc_detailValue";
const void *__bindObject = @"__lc_bindObject";

- (void)setLc_bindValue:(NSString *)lc_bindValue{
    objc_setAssociatedObject(self, __bindValue, lc_bindValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lc_bindValue {
    return objc_getAssociatedObject(self, __bindValue);
}


- (void)setLc_detailValue:(NSString *)lc_detailValue {
    objc_setAssociatedObject(self, __detailValue, lc_detailValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lc_detailValue {
    return objc_getAssociatedObject(self, __detailValue);
}


- (void)setLc_bindObject:(id)lc_bindObject {
      objc_setAssociatedObject(self, __bindObject, lc_bindObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)lc_bindObject {
        return objc_getAssociatedObject(self, __bindObject);
}
@end
