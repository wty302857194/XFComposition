//
//  PerLeftSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/24.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PerLeftSecondCell.h"

@implementation PerLeftSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.lable = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, 10, 10)];
        self.lable.layer.cornerRadius = 5;
        self.lable.layer.masksToBounds = YES;
        [self.contentView addSubview:self.lable];
        
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.lable.frame)+20, 10, WidthFrame*0.7 -120, 30)];
        self.label1.font  = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:self.label1];
        
//        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame*0.7-120, 10, 100, 30)];
//        self.label2.font  = [UIFont systemFontOfSize:16];
//        self.label2.textAlignment = NSTextAlignmentRight;
//        [self.contentView addSubview:self.label2];

    }
    return self;
}

@end
