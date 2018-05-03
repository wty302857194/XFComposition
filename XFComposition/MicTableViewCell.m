//
//  MicTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicTableViewCell.h"

@implementation MicTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 10, 10)];
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        label.backgroundColor = UIColorFromRGBA(255, 153, 18, 1.0f);
        [self.contentView addSubview:label];
        
        
        self.gradeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.gradeLabel];
        self.gradeLabel.text = @"【一年级】";
        self.gradeLabel.font = [UIFont systemFontOfSize:8];
        self.gradeLabel.sd_layout.leftSpaceToView(label, 10).topSpaceToView(self.contentView, 5).heightIs(15);
        [self.gradeLabel setSingleLineAutoResizeWithMaxWidth:0];
        
        self.nameLabel =[[UILabel alloc]init];
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.text = @"作文《我的家》";
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:8];
        
        self.nameLabel.sd_layout.leftSpaceToView(self.gradeLabel, 5).topEqualToView(self.gradeLabel).heightIs(15);
        [self.nameLabel setSingleLineAutoResizeWithMaxWidth:80];
        
        self.userLael =[[UILabel alloc]init];
        [self.contentView addSubview:self.userLael];
        self.userLael.text = @"赵笑笑";
        self.userLael.font = [UIFont systemFontOfSize:8];
        self.userLael.sd_layout.leftSpaceToView(self.nameLabel, 5).topEqualToView(self.gradeLabel).heightIs(15);
        [self.userLael setSingleLineAutoResizeWithMaxWidth:0];
        
//        self.teacherLabel =[[UILabel alloc]init];
//        [self.contentView addSubview:self.teacherLabel];
//        self.teacherLabel.font = [UIFont systemFontOfSize:8];
//        self.teacherLabel.text = @"批改老师：王乐乐";
//        self.teacherLabel.sd_layout.leftSpaceToView(self.userLael, 5).topEqualToView(self.gradeLabel).heightIs(20);
//        [self.teacherLabel setSingleLineAutoResizeWithMaxWidth:0];
        
        self.timeLabel =[[UILabel alloc]init];
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.text = @"2017/8/17 20:35";
        self.timeLabel.font = [UIFont systemFontOfSize:8];
        self.timeLabel.sd_layout.rightSpaceToView(self.contentView, 5).topEqualToView(self.gradeLabel).heightIs(15);
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:0];
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
