//
//  toolbarView.h
//  HuiToch
//
//  Created by 周凤喜 on 2017/8/19.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class toolbarView;
@protocol ToolDelegate <NSObject>

-(void)doSomething:(UIButton *)bt;

@end
@interface toolbarView : UIView
@property (nonatomic ,weak)id<ToolDelegate>delegate;

-(void)showView;
-(void)disMiss;
@end
