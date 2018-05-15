//
//  MyrecommenbookfristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MyrecommenbookfristCell.h"

@implementation MyrecommenbookfristCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, 100, 30)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.textColor = hexColor(333333);

        self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame-80, 3, 60, 30)];
        self.numLabel.font = [UIFont systemFontOfSize:14];
        self.numLabel.textColor = hexColor(333333);
        self.numLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.numLabel];
        
        UIImageView  *imgeV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39.5, WidthFrame, .5)];
        imgeV.backgroundColor = [UIColor colorWithHexString:@"E1E3E8"];
        [self.contentView addSubview:imgeV];
    }
    return self;
}

@end
