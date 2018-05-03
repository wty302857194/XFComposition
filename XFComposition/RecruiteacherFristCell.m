//
//  RecruiteacherFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RecruiteacherFristCell.h"

@implementation RecruiteacherFristCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.imageView = [[UIImageView alloc]init];
        self.mingelabel = [[UILabel alloc]init];
        self.titleLabel = [[UILabel alloc]init];
        self.timeLabel = [[UILabel alloc]init];
        self.xqlabel = [[UILabel alloc]init];
        self.textView = [[UITextView alloc]init];
        self.bmbt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView sd_addSubviews:@[self.imageView,self.titleLabel,self.timeLabel,self.xqlabel,self.textView,self.mingelabel,self.bmbt]];

        self.imageView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).widthIs(WidthFrame).heightIs(HeightFrame/4);
        
        self.titleLabel.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.imageView, 10).heightIs(30);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:0];
        
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.mingelabel.sd_layout.leftSpaceToView(self.titleLabel, 3).topSpaceToView(self.imageView, 12).autoHeightRatio(0);
        [self.mingelabel setSingleLineAutoResizeWithMaxWidth:0];
        self.mingelabel.font = [UIFont systemFontOfSize:10];
        self.mingelabel.textColor = [UIColor blueColor];

        
        self.timeLabel.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.titleLabel, 5).heightIs(20);
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
//        self.timeLabel.textColor = [UIColor lightGrayColor];
        
        
        self.xqlabel.sd_layout.leftEqualToView(self.timeLabel).topSpaceToView(self.timeLabel,10).heightIs(20);
        [self.xqlabel setSingleLineAutoResizeWithMaxWidth:0];
        self.xqlabel.font = [UIFont systemFontOfSize:12];
//        self.xqlabel.textColor = [UIColor lightGrayColor];
        
        self.textView.sd_layout.leftSpaceToView(self.xqlabel, 0).topSpaceToView(self.timeLabel,2).rightSpaceToView(self.contentView, 20).heightIs(100);
        
        self.textView.font = [UIFont systemFontOfSize:10];
        self.textView.editable = NO;
//        [self.textView setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];

        
        self.bmbt.sd_layout.leftSpaceToView(self.contentView,WidthFrame/4).topSpaceToView(self.textView, 0).heightIs(25).widthIs(WidthFrame/2);
        [self.bmbt setTitle:@"我要投稿" forState:UIControlStateNormal];
        [self.bmbt addTarget:self action:@selector(tougao) forControlEvents:UIControlEventTouchUpInside];
        self.bmbt.layer.masksToBounds = YES;
        self.bmbt.layer.cornerRadius = 6;
        self.bmbt.backgroundColor = [UIColor colorWithHexString:@"2791cf"];
        self.bmbt.titleLabel.font = [UIFont systemFontOfSize:12];
        
//        [self setupAutoHeightWithBottomView:self.textView bottomMargin:10];
        

    }

    return self;
}
//- (void)layoutIfNeeded{
//    [super layoutIfNeeded];
//
//
//    
//}
-(void)tougao{
    
    if ([self.delegate respondsToSelector:@selector(Submission)]) {
        [self.delegate Submission];
    }

}
//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//    [self layoutSubviews];
//    [self layoutIfNeeded];
//    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
//    CGRect newFrame = layoutAttributes.frame;
//    newFrame.size.height = size.height;
//    layoutAttributes.frame = newFrame;
//    return layoutAttributes;
//}


@end
