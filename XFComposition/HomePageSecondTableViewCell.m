//
//  HomePageSecondTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

/****
 活动cel
 
 ****/
#import "HomePageSecondTableViewCell.h"
@interface HomePageSecondTableViewCell ()

@end
@implementation HomePageSecondTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 14, 14)];
        label.layer.cornerRadius = 7;
        label.clipsToBounds = YES;
        label.backgroundColor = UIColorFromRGBA(255, 153, 18, 1.0f);
        [self.contentView addSubview:label];
        
        self.homeTextLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.homeTextLabel];
//        self.homeTextLabel.text = @"cweoepepepepe";
        self.homeTextLabel.font = [UIFont systemFontOfSize:11];
        self.homeTextLabel.sd_layout.leftSpaceToView(label, 20).topSpaceToView(self.contentView,10).heightIs(20);
        [self.homeTextLabel setSingleLineAutoResizeWithMaxWidth:0];
        
        self.CommentLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.CommentLabel];
        self.CommentLabel.text = @"点评时间：";
        self.CommentLabel.font = [UIFont systemFontOfSize:11];
        self.CommentLabel.sd_layout.topSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10).heightIs(20);
        [self.CommentLabel setSingleLineAutoResizeWithMaxWidth:0];
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
