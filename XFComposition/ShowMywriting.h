//
//  ShowMywriting.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/9.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShowMywriting;
@protocol ShowMywritingDelegate <NSObject>

-(void)Savezuowen;
-(void)Upload :(UIButton *)bt;

@end

@interface ShowMywriting : UIView
@property (nonatomic,strong)UITextField *titletextfield;
@property (nonatomic,strong)UITextView *textview;
@property (nonatomic,weak)id<ShowMywritingDelegate>delegate;
-(void)showView;
-(void)dismissView;
@end
