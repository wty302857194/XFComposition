//
//  MicHBWriterequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/15.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^HBWriteBlock)(NSDictionary *);
@interface MicHBWriterequst : NSObject
-(void)MicHBWriterequstWithclassId :(NSString *)classID  ids:(NSString *)ids withModelld :(NSString *)modeleid withUserID :(NSString *)userid :(HBWriteBlock)blcok;
@end
