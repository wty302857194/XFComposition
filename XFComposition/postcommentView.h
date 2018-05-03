//
//  postcommentView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class postcommentView;
@protocol  postcommentViewDelegate<NSObject>

-(void)clickfb :(UIButton *)bt;

@end
@interface postcommentView : UIView

@property (nonatomic,strong)UITextView *textview;
@property (nonatomic,weak)id<postcommentViewDelegate>delegate;
-(void)showView;
-(void)dissMiss;
@end
