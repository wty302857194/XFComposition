//
//  JXAlertview.h
//  customalert
//
//  Created by jiangxiao on 14-7-8.
//  Copyright (c) 2014年 jiangxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomAlertDelegete <NSObject>

-(void)btnindex:(int)index :(int) tag;

@end
@interface JXAlertview : UIImageView
@property(nonatomic,retain)UILabel *title;
@property(nonatomic,retain)UILabel *message;
@property(nonatomic,retain)UIButton *cancelbtn;
@property(nonatomic,retain)UIButton *surebtn;
@property (nonatomic,retain) id<CustomAlertDelegete> delegate;
//-(void)dismmis1;
-(void)initwithtitle:(NSString *)str andmessage:(NSString *)str1 andcancelbtn:(NSString *)cancel andotherbtn:(NSString *)other;
-(void)show;
-(void)showview;
-(void)dismmis;
//-(void)dismmis;

@end
