//
//  MarkSDView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MarkSDView;
@protocol MarkSDViewDelegate <NSObject>
-(void)shoudongbaocun:(NSString *)str1 :(NSString *)str2 :(NSString *)str3 :(NSString *)str4 :(NSString *)str5;
@end
@interface MarkSDView : UIView
@property (nonatomic,weak)id<MarkSDViewDelegate>delegate;
-(void)showView;
-(void)dissMiss;
@end
