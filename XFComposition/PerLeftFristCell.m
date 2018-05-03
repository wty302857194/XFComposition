//
//  PerLeftFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/24.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PerLeftFristCell.h"

@implementation PerLeftFristCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 30, 20)];;
        [self.contentView addSubview:self.imgView];
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame)+20, 10, WidthFrame*.7 -120, 30)];
        self.label1.font  = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:self.label1];
        
//        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame*0.7-120, 10, 100, 30)];
//        self.label2.font  = [UIFont systemFontOfSize:16];
//        self.label2.textAlignment = NSTextAlignmentRight;
//        [self.contentView addSubview:self.label2];
        
        self.label2 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label2];
        self.label2.sd_layout.rightSpaceToView(self.contentView, WidthFrame*0.3+20).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(20);
        self.label2.layer.cornerRadius = 10;
        self.label2.layer.masksToBounds = YES;
        self.label2.textColor = [UIColor whiteColor];
        self.label2.backgroundColor = [UIColor redColor];
        self.label2.textAlignment = NSTextAlignmentCenter;
        [self.label2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];//加粗
        
    }
    return self;
}
@end
