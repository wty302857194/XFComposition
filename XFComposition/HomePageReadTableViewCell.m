//
//  HomePageReadTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePageReadTableViewCell.h"
@interface HomePageReadTableViewCell ()

@end

@implementation HomePageReadTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *midLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame/2, 2, 0.5, 84)];
        midLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:midLabel];
        CGFloat imageW = WidthFrame/4-30;
        self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, imageW, 84)];
        self.imageView1.backgroundColor = [UIColor yellowColor];
//        self.imageView1.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:self.imageView1];
        
        for (int j = 0; j<6; j++) {
            self.label1 = [[UILabel alloc]init];
            self.label1.frame = CGRectMake(CGRectGetMaxX(self.imageView1.frame)+10, 0+15*j, WidthFrame/2, 15);
            self.label1.tag = 1000+j;
//            self.label1.text = @"推荐时间";
            self.label1.font = [UIFont systemFontOfSize:9];
            [self.contentView addSubview:self.label1];
        }
        
        self.imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(midLabel.frame)+5, 0, imageW, 84)];
        self.imageView2.backgroundColor = [UIColor lightGrayColor];
//        self.imageView2.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:self.imageView2];
        for (int i = 0; i<6; i++) {
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(CGRectGetMaxX(self.imageView2.frame)+10, 0+15*i, WidthFrame/2, 15);
            label.tag = 2000+i;
            label.text = @"推荐时间";
            label.font = [UIFont systemFontOfSize:9];
            [self.contentView addSubview:label];
        }
    }
    return  self;
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
