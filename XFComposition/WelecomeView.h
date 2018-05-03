//
//  WelecomeView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WelecomeView ;
@protocol WelecomeViewDelegate <NSObject>

-(void)removeWelecomeView;

@end
@interface WelecomeView : UIView
@property (nonatomic,weak)id<WelecomeViewDelegate>delegate;
@end
