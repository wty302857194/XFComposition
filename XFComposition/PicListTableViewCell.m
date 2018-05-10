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
    _label = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, (kScreenWidth - 14)/2, 44)];
    _label.font = [UIFont systemFontOfSize:14];
    _label.textColor = hexColor(333333);
     [self.contentView addSubview:_label];
    _starReplay = [[QYStarReplay alloc] initWithFrame:CGRectMake((kScreenWidth - 14)/2 + 14, 0, (kScreenWidth - 14)/2, 44) numberOfStars:5 rateStyle:RateStyleHalfStar isAnination:YES finish:^(CGFloat currentScore) {
        
        
    }];
    [self.contentView addSubview:_starReplay];
}
-(void)reloadData:(FMBean*)bean{
    
    StandardInfo * model = (StandardInfo*)bean;
    
    _label.text = model.StandardText;
  
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
