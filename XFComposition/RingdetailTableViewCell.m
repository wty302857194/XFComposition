//
//  RingdetailTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RingdetailTableViewCell.h"

@implementation RingdetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        self.imgView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.imgView];
        
        self.userLabel = [[UILabel alloc]init];
        self.timeLabel = [[UILabel alloc]init];
        self.titleLbel = [[UILabel alloc]init];
        self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView sd_addSubviews:@[self.userLabel,self.timeLabel,self.titleLbel,self.bt1,self.bt2]];
        
        self.userLabel.sd_layout.leftSpaceToView(self.contentView, 50).topSpaceToView(self.contentView, 10).heightIs(20);
        [self.userLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.userLabel.text = @"豆豆0101";
        self.userLabel.font = [UIFont systemFontOfSize:14];
        
        self.timeLabel.sd_layout.leftSpaceToView(self.contentView,50).topSpaceToView(self.userLabel, 5).heightIs(15);
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.timeLabel.text = @"2017.08.09";
        self.timeLabel.font = [UIFont systemFontOfSize:10];
        self.titleLbel.sd_layout.leftSpaceToView(self.contentView, 50).topSpaceToView(self.timeLabel, 15).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
//        [self.titleLbel setSingleLineAutoResizeWithMaxWidth:WidthFrame/3*2];
        self.titleLbel.text = @"豆豆参与了主题征文活动";
        self.titleLbel.font = [UIFont systemFontOfSize:12];
        
        self.bt1.sd_layout.rightSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 10).widthIs(80).heightIs(20);
//        [self.bt1 setTitle:@"评论" forState: UIControlStateNormal];
        [self.bt1 setImage:[UIImage imageNamed:@"icon_liulan"] forState:UIControlStateNormal];
        [self.bt1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.bt1.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.bt1 setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        self.bt2.sd_layout.rightSpaceToView(self.contentView, 0).topSpaceToView(self.bt1, 0).widthIs(80).heightIs(20);
        //        [self.bt1 setTitle:@"评论" forState: UIControlStateNormal];
        [self.bt2 setImage:[UIImage imageNamed:@"icon_canjia-1"] forState:UIControlStateNormal];
        [self.bt2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.bt2.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.bt2 setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        [self setupAutoHeightWithBottomView:self.titleLbel bottomMargin:10];
    }
    return self;
}
-(void)setModel:(GetMyHtListModel *)model{
    _model = model;
    
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,_model.UserPic];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
    
    self.userLabel.text = _model.UserName;
    self.timeLabel.text = _model.AddTime;
    self.titleLbel.text = _model.title;
    [self.bt1 setTitle:[NSString stringWithFormat:@"%@",_model.viewNum] forState: UIControlStateNormal];
//    NSLog(@"%@",_model.plNum);
//    if ([_model.plNum integerValue] == 0) {
//        _model.plNum = @"0";
//    }
    [self.bt2 setTitle:[NSString stringWithFormat:@"%ld",(long)_model.plNum] forState: UIControlStateNormal];
}
@end
