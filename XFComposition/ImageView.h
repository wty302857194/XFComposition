//
//  ImageView.h
//  HuiToch
//
//  Created by 周凤喜 on 2017/8/19.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageView;

@protocol ImageViewDelegate <NSObject>

-(void)showAlter :(ImageView *)imgView;

@end
@interface ImageView : UIView
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)id<ImageViewDelegate>delegate;
-(void)showView;
-(void)dissMiss;
@end
