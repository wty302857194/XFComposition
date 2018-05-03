//
//  GetTitleInfoRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/22.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetTitleInfoBlock)(NSDictionary *);
@interface GetTitleInfoRequst : NSObject
-(void)GetTitleInfoRequstwithid :(NSString *)ringID :(GetTitleInfoBlock)block;
@end
