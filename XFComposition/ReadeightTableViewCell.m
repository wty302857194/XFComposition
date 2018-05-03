//
//  ReadeightTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadeightTableViewCell.h"

@implementation ReadeightTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, 16, 16)];
        self.numLabel.backgroundColor = [UIColor lightGrayColor];
        self.numLabel.layer.cornerRadius = 8;
        self.numLabel.clipsToBounds = YES;
        self.numLabel.textColor = [UIColor whiteColor];
        self.numLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.numLabel];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.numLabel.frame)+10, 0, WidthFrame/2-80, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.titleLabel];

    }
    return self;
}
@end
