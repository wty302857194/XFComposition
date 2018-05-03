

//
//  RecruitableviewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RecruitableviewCell.h"

@implementation RecruitableviewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 40, 40)];
        self.imgView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.imgView];
        
        self.teacherLabel = [[UILabel alloc]init];
        self.xuexiaoLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.teacherLabel];
        [self.contentView addSubview:self.xuexiaoLabel];
        
        self.teacherLabel.sd_layout.leftSpaceToView(self.contentView, 80).topSpaceToView(self.contentView, 10).heightIs(20);
        [self.teacherLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.teacherLabel.text =@"冷小冷老师";
        self.teacherLabel.font = [UIFont systemFontOfSize:12];
        self.xuexiaoLabel.sd_layout.leftSpaceToView(self.contentView, 80).topSpaceToView(self.teacherLabel, 5).heightIs(15);
        [self.xuexiaoLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.xuexiaoLabel.text = @"南京秦淮一小";
        self.xuexiaoLabel.layer.masksToBounds = YES;
        self.xuexiaoLabel.layer.cornerRadius = 6;
        self.xuexiaoLabel.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        self.xuexiaoLabel.layer.borderWidth = 0.5;
        self.xuexiaoLabel.font = [UIFont systemFontOfSize:10];
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
