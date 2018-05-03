//
//  ReplaceCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReplaceCell.h"

@implementation ReplaceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"EEEFF3"];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame/2-40, self.frame.size.height/2-20, 80, 40)];
        label.text = @"暂无数据";
        label.textColor = [UIColor colorWithHexString:@"A3A4A3"];
        [self.contentView addSubview:label];
    }
    return self;
}
@end
