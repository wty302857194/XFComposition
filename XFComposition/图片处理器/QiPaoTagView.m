//
//  QiPaoTagView.m
//  MyPracticeViewController
//
//  Created by wbb on 2018/5/10.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "QiPaoTagView.h"
#import "FSTextView.h"

@implementation QiPaoTagView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 加载图片
        UIImage *image = [UIImage imageNamed:@"气泡-2.png"];
        
        // 设置左边端盖宽度
        NSInteger leftCapWidth = image.size.width * 0.5;
        // 设置上边端盖高度
        NSInteger topCapHeight = image.size.height * 0.5;
        
        UIImage *newImage = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        imgView.image = newImage;
        [self addSubview:imgView];
        
        _textView = [[FSTextView alloc] init];
        _textView.textColor = [UIColor whiteColor];
        _textView.userInteractionEnabled = YES;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.placeholder = @"请输入批改内容";
        _textView.placeholderColor = [UIColor whiteColor];
         __weak typeof(self) weakSelf = self;
        [_textView addTextDidChangeHandler:^(FSTextView *textView) {
           float height = [Global heightForText:textView.text textFont:15 standardWidth:weakSelf.frame.size.width]+20;
            if (height>weakSelf
                .frame.size.height) {
                CGRect newFrame = weakSelf.frame;
                newFrame.size.height = height+24;
                weakSelf.frame = newFrame;
                imgView.frame = weakSelf.bounds;
            }
            
            if (weakSelf.contentStrBlock) {
                weakSelf.contentStrBlock(textView.text);
            }
        }];
        [self addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(12);
            make.bottom.mas_equalTo(-12);
            make.right.mas_equalTo(-5);
        }];
        
        
        
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGRAct:)];
        [self setUserInteractionEnabled:YES];
        [self addGestureRecognizer:panGR];
        
    }
    return self;
}
- (void)panGRAct: (UIPanGestureRecognizer *)rec{
    
    
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
    
    rec.view.frame = CGRectMake(ty_x-self.width/2.f, ty_y - self.height/2.f, self.frame.size.width, self.frame.size.height);
}
@end
