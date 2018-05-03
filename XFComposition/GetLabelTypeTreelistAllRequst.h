//
//  GetLabelTypeTreelistAllRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetLabelTypeTreelistAllBlock)(NSDictionary *);
@interface GetLabelTypeTreelistAllRequst : NSObject
-(void)GetLabelTypeTreelistAllRequstwithID :(NSString *)ID withFlag :(NSString *)Flag withmodelid :(NSString *)modelid :(GetLabelTypeTreelistAllBlock)block;
@end
