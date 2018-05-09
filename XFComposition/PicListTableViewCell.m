//
//  PicListTableViewCell.m
//  XFComposition
//
//  Created by qiannian on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "PicListTableViewCell.h"
#import "QYStarReplay.h"
#import "GetWritePicModel.h"
@implementation PicListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)reloadData:(FMBean*)bean{
    
    GetWritePicModel * model = (GetWritePicModel*)bean;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, (kScreenWidth - 14)/2, 44)];
    label.text = model.FixPicUrl;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = hexColor(333333);
    [self.contentView addSubview:label];
    
    QYStarReplay * starReplay = [[QYStarReplay alloc] initWithFrame:CGRectMake((kScreenWidth - 14)/2 + 14, 0, (kScreenWidth - 14), 44) numberOfStars:5 rateStyle:RateStyleHalfStar isAnination:YES finish:^(CGFloat currentScore) {
        
    }];
    [self.contentView addSubview:starReplay];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
