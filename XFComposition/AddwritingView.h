//
//  AddwritingView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddwritingViewDelegate <NSObject>

-(void)newWriting;

@end

@interface AddwritingView : UIView
@property (nonatomic,strong)UITextField *titletextfield;
@property (nonatomic,strong)UITextView *textview;
@property (nonatomic,strong)id<AddwritingViewDelegate>delegate;
-(void)showView;
-(void)dismissView;
@end


