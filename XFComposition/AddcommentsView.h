//
//  AddcommentsView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddcommentsView;
@protocol Microbaocundelegate <NSObject>

-(void)preservestage;

@end

@interface AddcommentsView : UIView
@property (nonatomic,strong)UITextField *titletextfield;
@property (nonatomic,strong)UITextView *textview;
@property (nonatomic,strong)id<Microbaocundelegate>delegate;
-(void)showView;
-(void)dismissView;

@end
