//
//  MicroPianduanCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicroPianduanCell.h"

@implementation MicroPianduanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label1 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label1];
        self.label1.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 5).heightIs(20);
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
        self.label1.font = [UIFont systemFontOfSize:10];
        
//        self.label1.text = @"[锁定]";
        self.label2 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label2];
        self.label2.sd_layout.leftSpaceToView(self.label1, 2).topEqualToView(self.label1).heightIs(20);
        [self.label2 setSingleLineAutoResizeWithMaxWidth:0];
        self.label2.font = [UIFont systemFontOfSize:10];
        self.label2.text =@"三年是多久";
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
