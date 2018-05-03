//
//  ShowtextView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/15.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShowtextView;
@protocol showtextDelegate <NSObject>

-(void)hold :(NSString *)Id;

@end

@interface ShowtextView : UIView
@property (nonatomic,strong)UITextField *titletextfield;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UILabel *timeLabel1;
@property (nonatomic,strong)UILabel *timeLabel2;
@property (nonatomic,strong)UIButton *baocunBt;

@property (nonatomic,strong)NSString *typeId;
@property (nonatomic,strong)NSString *edit;
@property (nonatomic,strong)id<showtextDelegate>delegate;
-(void)showView;
-(void)dissMiss;
@end
