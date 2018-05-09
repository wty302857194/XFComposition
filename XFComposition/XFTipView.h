//
//  XFTipView.h
//  XinFangBao
//
//  Created by qiannian on 16/7/27.
//  Copyright © 2016年 house365. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XFTipViewDelegate <NSObject>
-(void)action:(id)sender;
@end

typedef void(^ButtonActionBlock)(void);

@interface XFTipView : UIView

@property (strong, nonatomic) IBOutlet UIImageView *tipImgeView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *tipButton;
@property (nonatomic, weak) id <XFTipViewDelegate> delegate;
@property (nonatomic,copy) ButtonActionBlock buttonActionBlock;

- (void)setTipString:(NSString *)tipString;
- (void)setTipButtnString:(NSString*)tipString;

@end
