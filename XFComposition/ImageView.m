//
//  ImageView.m
//  HuiToch
//
//  Created by 周凤喜 on 2017/8/19.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ImageView.h"

@interface ImageView ()<UITextViewDelegate,UIGestureRecognizerDelegate>

@end
@implementation ImageView
-(UITextView *)textView{
    if (!_textView) {
//        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        _textView = [[UITextView alloc]init];
//        CGFloat h = [self heightForString:_textView andWidth:WidthFrame/2-15];
        _textView.frame = CGRectMake(0, 0, WidthFrame/2-15, 30);
//        _textView.backgroundColor = [UIColor lightGrayColor];
        _textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _textView.layer.borderWidth = 2;
        _textView.delegate = self;
        _textView.textColor = [UIColor redColor];
        
    }
    return _textView;
}
- (float) heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled =YES;

        self.backgroundColor = [UIColor colorWithHexString:@"348DCC"];
        [self addSubview:self.textView];
//        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(135, 0, 15, 15)];
//        [bt addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
//        [bt setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
//        [bt setBackgroundColor:[UIColor whiteColor]];
//        [self addSubview:bt];
        
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGRAct:)];
        [self setUserInteractionEnabled:YES];
        [self addGestureRecognizer:panGR];
        [self creatLongPress]; 
        
        
    }
    return self;
}
#pragma mark 长按出工具箱
-(void)creatLongPress{
    //长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPressGesture.delegate = self;
    [self addGestureRecognizer:longPressGesture];
    
    
}
-(void) longPress: (UILongPressGestureRecognizer *) gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        //        NSLog(@"长按开始");
//        self.textView.editable = NO;
        if ([self.delegate respondsToSelector:@selector(showAlter :)]) {
            [self.delegate showAlter :self];
        }
        
        
    }else if (gesture.state == UIGestureRecognizerStateEnded){
        //        NSLog(@"长按结束");
//        self.textView.editable = YES;
        
    }
    else {
        //        NSLog(@"长按中");
        
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    static CGFloat maxHeight =120.0f;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height<=frame.size.height) {
        size.height=frame.size.height;
    }else{
        if (size.height >= maxHeight)
        {
            size.height = maxHeight;
            textView.scrollEnabled = YES;   // 允许滚动
        }
        else
        {
            textView.scrollEnabled = NO;    // 不允许滚动
        }
    }
    self.textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);

}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return false;
    }
    return true;
}



//拖动手势
- (void)panGRAct: (UIPanGestureRecognizer *)rec{
    
    
    CGPoint point = [rec translationInView:self];
//    NSLog(@"%f,%f",point.x,point.y);
    rec.view.center = CGPointMake(rec.view.center.x + point.x, rec.view.center.y + point.y);
    [rec setTranslation:CGPointMake(0, 0) inView:self];
//    [self.refreshControl insertSubView:backgroundImageView atIndex:0];
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer*) gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*) otherGestureRecognizer{
    
    if([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] && [NSStringFromClass([otherGestureRecognizer class])isEqualToString:@"UITextTapRecognizer"]){
        
        return NO;
        
    }
    return YES;
    
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender

{
    
    return NO;
    
    
    
}

-(void)showView{

}
-(void)dissMiss{
    [self removeFromSuperview];
}

@end
