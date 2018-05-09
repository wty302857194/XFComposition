//
//  XFTipView.m
//  XinFangBao
//
//  Created by qiannian on 16/7/27.
//  Copyright © 2016年 house365. All rights reserved.
//

#import "XFTipView.h"

@interface XFTipView ()

@end

@implementation XFTipView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setTipString:(NSString *)tipString
{
    self.tipLabel.text = tipString;
}

- (void)setTipButtnString:(NSString*)tipString
{
    [self.tipButton setTitle:tipString forState:UIControlStateNormal];
}

- (IBAction)button_Action:(id)sender{

    if (_delegate&& [_delegate respondsToSelector:@selector(action:)]) {
        [_delegate action:sender];
    }
    
    if (self.buttonActionBlock) {
        self.buttonActionBlock();
    }
}


@end
