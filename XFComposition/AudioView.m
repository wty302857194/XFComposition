//
//  AudioView.m
//  XFComposition
//
//  Created by qiannian on 2018/5/14.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "AudioView.h"

@implementation AudioView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGRAct:)];
        [self setUserInteractionEnabled:YES];
        [self addGestureRecognizer:panGR];
        [self creatLongPress];
        self.backgroundColor = [UIColor redColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
    
}
// 轻点
-(void)tapAction:(UIGestureRecognizer*)gesRec{
    
    
    if (_tapBlock) {
        _tapBlock();
    }
}
//拖动
-(void)panGRAct:(UIPanGestureRecognizer*)gesRec{
    
    CGPoint point = [gesRec translationInView:self];
    //    NSLog(@"%f,%f",point.x,point.y);
    gesRec.view.center = CGPointMake(gesRec.view.center.x + point.x, gesRec.view.center.y + point.y);
    [gesRec setTranslation:CGPointMake(0, 0) inView:self];
    if (_panBlock) {
        _panBlock(gesRec.view.center);
    }
}
-(void)longPress:(UIGestureRecognizer*)gesRec{
    
    
    
    
}
#pragma mark 长按出工具箱
-(void)creatLongPress{
    //长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPressGesture.delegate = self;
    [self addGestureRecognizer:longPressGesture];
    
    
}

@end
