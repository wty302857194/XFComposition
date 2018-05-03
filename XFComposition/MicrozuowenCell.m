//
//  MicrozuowenCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicrozuowenCell.h"

@implementation MicrozuowenCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label1 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label1];
        self.label1.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 0).heightIs(20);
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
        self.label1.font = [UIFont systemFontOfSize:10];
        self.label1.text = @"[已保存]";
        self.label2 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label2];
        self.label2.sd_layout.leftSpaceToView(self.label1, 2).topEqualToView(self.label1).heightIs(20);
        [self.label2 setSingleLineAutoResizeWithMaxWidth:0];
        self.label2.font = [UIFont systemFontOfSize:10];
        self.label2.text =@"[已提交]";
        
        self.label3 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label3];
        self.label3.sd_layout.leftSpaceToView(self.label2, 2).topEqualToView(self.label1).heightIs(20);
        [self.label3 setSingleLineAutoResizeWithMaxWidth:0];
        self.label3.font = [UIFont systemFontOfSize:10];
        self.label3.text = @"稿件1";
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
