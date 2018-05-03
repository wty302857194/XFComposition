//
//  GetActiveSubectByGuiZeRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GetActiveSubectByGuiZeBlock)(NSDictionary *);
@interface GetActiveSubectByGuiZeRequst : NSObject
-(void)GetActiveSubectByGuiZeRequstwithDanXuanSubjectNum :(NSString *)DanXuanSubjectNum withDuoXuanSubjectNum :(NSString *)DuoXuanSubjectNum withPanDuanSubjectNum :(NSString *)PanDuanSubjectNum withTianKongSubjectNum :(NSString *)TianKongSubjectNum withWenDaSubjectNum :(NSString *)WenDaSubjectNum withActiveID :(NSString *)ActiveID withuserid :(NSString *)userid :(GetActiveSubectByGuiZeBlock)block;
@end
