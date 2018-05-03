//
//  ReadTenTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadTenTableViewCell.h"

@implementation ReadTenTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 10, 10)];
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        label.backgroundColor = UIColorFromRGBA(255, 153, 18, 1.0f);
        [self.contentView addSubview:label];
        
        CGFloat w = (WidthFrame/2-50)/3;
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, w, 20)];
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.label1.frame)+5, 0, w, 20)];
        self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.label2.frame), 0, w+5, 20)];
        self.label1.font = [UIFont systemFontOfSize:10];
        self.label2.font = [UIFont systemFontOfSize:10];
        self.label3.font = [UIFont systemFontOfSize:9];
        
        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.label2];
        [self.contentView addSubview:self.label3];
    }
    return self;
}

@end
