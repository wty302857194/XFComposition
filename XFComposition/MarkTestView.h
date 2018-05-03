//
//  MarkTestView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetActiveSubectByGuiZeModel.h"
@class MarkTestView;
@protocol MarkTestViewDelegate <NSObject>

-(void)sureMake :(GetActiveSubectByGuiZeModel *)model :(NSString *)str;
-(void)SaveTest :(NSString *)str1 :(NSString *)str2 :(NSString *)str3 :(NSString *)str4 :(NSString *)str5 :(NSString *)str6 :(NSString *)str7 :(NSString *)str8;
@end


@interface MarkTestView : UIView

@property (nonatomic,weak)id<MarkTestViewDelegate>delegate;

-(void)showView;
-(void)dissMiss;

@end
