//
//  ShowContentView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/9.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowContentView : UIView
@property (nonatomic,strong)UITextField *titletextfield;
@property (nonatomic,strong)UITextView *textview;

-(void)showView;
-(void)dismissView;
@end
