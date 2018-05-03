//
//  ThridCollectionViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/29.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ThridCollectionViewCell.h"

@implementation ThridCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor grayColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColorFromRGBA(135, 206, 235, 1.0f) CGColor];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-30, HeightFrame/6-30)];
//        self.textView.backgroundColor = [UIColor lightGrayColor];
        NSString *str = @"    我哦我哦啊我的技术都没什么速度快说的模式没事的上面垫觉得上面垫没事";
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:11],
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        self.textView.attributedText = [[NSAttributedString alloc] initWithString:str attributes:attributes];
        
    
        self.textView.editable = NO;
        
//        self.textView.text=@"我哦我哦啊我的技术都没什么速度快说的模式没事的上面垫觉得上面垫没事";
        [self addSubview:self.textView];
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightFrame/6-30,WidthFrame/2-30-10 , 30)];
//        self.label.sd_layout.topSpaceToView(<#UIView *toView#>, <#CGFloat value#>)
        self.label.textAlignment = NSTextAlignmentRight;
        self.label.text =@"摘自（《雨》）";
        self.label.font = [UIFont systemFontOfSize:11];
        [self addSubview:self.label];
        
    }
    return  self;
}

@end
