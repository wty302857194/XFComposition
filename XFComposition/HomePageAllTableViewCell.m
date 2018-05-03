//
//  HomePageAllTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePageAllTableViewCell.h"

@implementation HomePageAllTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 20, 20)];
        label.layer.cornerRadius = 10;
        label.clipsToBounds = YES;
        label.backgroundColor = UIColorFromRGBA(255, 153, 18, 1.0f);
        [self.contentView addSubview:label];
        
//        self.label1 = [UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+5, 5, <#CGFloat width#>, <#CGFloat height#>)
        self.label1 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label1];
        self.label1.font = [UIFont systemFontOfSize:12];
        self.label1.sd_layout.leftSpaceToView(label, 5).topSpaceToView(self.contentView,7).heightIs(20);
        
        [self.label1 setSingleLineAutoResizeWithMaxWidth:80];
        
        self.label2 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label2];
        self.label2.textAlignment = NSTextAlignmentCenter;
        self.label2.font = [UIFont systemFontOfSize:12];
        self.label2.sd_layout.leftSpaceToView(self.label1, 5).topSpaceToView(self.contentView,7).heightIs(20);
        [self.label2 setSingleLineAutoResizeWithMaxWidth:130];
        
        self.label3 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label3];
        self.label3.font = [UIFont systemFontOfSize:12];
        self.label3.sd_layout.leftSpaceToView(self.label2, 5).topSpaceToView(self.contentView,7).heightIs(20);
        
        [self.label3 setSingleLineAutoResizeWithMaxWidth:0];
        
        self.label4 = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.label4];
        self.label4.font = [UIFont systemFontOfSize:12];
        self.label4.sd_layout.rightSpaceToView(self.contentView, 10).topSpaceToView(self.contentView,7).heightIs(20);
        [self.label4 setSingleLineAutoResizeWithMaxWidth:160];
        
        
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
