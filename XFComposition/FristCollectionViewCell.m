//
//  FristCollectionViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/29.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "FristCollectionViewCell.h"
#import "WriteListModel.h"
@interface FristCollectionViewCell ()

@end
@implementation FristCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, HeightFrame/8-20, HeightFrame/8-20)];
        
        self.imageView.layer.cornerRadius = 6;
        self.imageView.clipsToBounds = YES;
        
        
        [self addSubview:self.imageView];
        CGFloat h =( HeightFrame/8 -20)/5;
        CGFloat w= WidthFrame/2-7 -10 -(HeightFrame/8-20)-5;
        

        self.titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.sd_layout.leftSpaceToView(self.imageView, 5).topSpaceToView(self.contentView, 10).heightIs(h);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:w-10];
        [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:9]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.rightLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.rightLabel];
        
        self.rightLabel.sd_layout.leftSpaceToView(self.titleLabel, 0).topEqualToView(self.titleLabel).heightIs(h);
        [self.rightLabel setSingleLineAutoResizeWithMaxWidth:0];
        
        [self.rightLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:9]];
        self.rightLabel.textAlignment = NSTextAlignmentCenter;
        
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame)+5, h+10, w-5, h)];
        self.nameLabel.font = [UIFont systemFontOfSize:8];
        
        [self addSubview:self.nameLabel];
        
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame)+5, CGRectGetMaxY(self.nameLabel.frame), w-5, h)];
        
        self.numberLabel.font = [UIFont systemFontOfSize:8];
        
        [self addSubview:self.numberLabel];
        
        self.njLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame)+5, CGRectGetMaxY(self.numberLabel.frame), w-5, h)];
        
        self.njLabel.font = [UIFont systemFontOfSize:8];
        self.njLabel.text = @"年级:三年级二班";
        [self addSubview:self.njLabel];
        
        self.bqLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame)+5, CGRectGetMaxY(self.njLabel.frame), w-5, h)];
        
        self.bqLabel.font = [UIFont systemFontOfSize:8];
        [self addSubview:self.bqLabel];
       
    }
    return  self;
}


-(void)layoutSubviews{
    
    


    

}
@end
