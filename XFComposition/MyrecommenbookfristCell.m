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
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.titleLabel];
        
        self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame-80, 3, 60, 30)];
        self.numLabel.font = [UIFont systemFontOfSize:16];
        self.numLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.numLabel];
        
        UILabel *dipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 38, WidthFrame, 2)];
        dipLabel.backgroundColor = [UIColor colorWithHexString:@"E1E3E8"];
        [self.contentView addSubview:dipLabel];
    }
    return self;
}

@end
