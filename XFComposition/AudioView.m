//
//  AudioView.m
//  XFComposition
//
//  Created by qiannian on 2018/5/14.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "AudioView.h"
@interface AudioView ()<UIGestureRecognizerDelegate>

@end

@implementation AudioView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGRAct:)];
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:panGR];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
    //长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPressGesture.delegate = self;
    [self addGestureRecognizer:longPressGesture];
}

// 轻点
-(void)tapAction:(UIGestureRecognizer*)gesRec {
    if (_tapBlock) {
        _tapBlock();
    }
}
//拖动
-(void)panGRAct:(UIPanGestureRecognizer*)rec {
    
//    CGPoint point = [gesRec translationInView:self];
//    //    NSLog(@"%f,%f",point.x,point.y);
//    gesRec.view.center = CGPointMake(gesRec.view.center.x + point.x, gesRec.view.center.y + point.y);
//    [gesRec setTranslation:CGPointMake(0, 0) inView:self];
//    if (_panBlock) {
//        _panBlock(gesRec.view.center);
//    }
    
    CGPoint point = [rec translationInView:self];
    NSLog(@"%f,%f",point.x,point.y);
    float ty_x = rec.view.center.x + point.x;
    if ((ty_x-self.width/2.f)<0) {
        ty_x = self.width/2.f;
    }
    if (ty_x+self.width/2.f>self.superview.width) {
        ty_x = self.superview.width - self.width/2.f;
    }
    
    float ty_y = rec.view.center.y + point.y;
    if((ty_y-self.height/2.f)<0) {
        ty_y = self.height/2.f;
    }
    if (ty_y+self.height/2.f>self.superview.height) {
        ty_y = self.superview.height - self.height/2.f;
    }
    rec.view.center = CGPointMake(ty_x, ty_y);
    [rec setTranslation:CGPointMake(0, 0) inView:self];
    
//    rec.view.frame = CGRectMake(ty_x-self.width/2.f, ty_y - self.height/2.f, self.frame.size.width, self.frame.size.height);
    
    if (_panBlock) {
        _panBlock(rec.view.center);
    }
}
-(void)longPress:(UIGestureRecognizer*)gesRec {
 
}

@end
