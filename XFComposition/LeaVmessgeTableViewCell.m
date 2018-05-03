//
//  LeaVmessgeTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "LeaVmessgeTableViewCell.h"
@interface LeaVmessgeTableViewCell()<UITableViewDelegate,UITableViewDelegate>
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *cotentLabel;
@end
@implementation LeaVmessgeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]init];
        self.nameLabel = [[UILabel alloc]init];
        self.timeLabel = [[UILabel alloc]init];
        self.cotentLabel = [[UILabel alloc]init];
        UILabel *dipLabel = [[UILabel alloc]init];
        [self.contentView sd_addSubviews:@[self.imgView,self.nameLabel,self.timeLabel,self.cotentLabel,dipLabel]];
        
        self.imgView.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 5).widthIs(30).heightIs(30);
        self.imgView.layer.masksToBounds= YES;
        self.imgView.layer.cornerRadius = 15;
        
        self.nameLabel.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.contentView, 5).heightIs(30).widthIs(0);
        [self.nameLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        
        self.timeLabel.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.nameLabel, 10).heightIs(20).widthIs(0);
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = [UIColor colorWithHexString:@"A3A4A3"];
        
        self.cotentLabel.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.timeLabel, 10).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
        self.cotentLabel.font = [UIFont systemFontOfSize:12];
        
//        dipLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.cotentLabel, 5).rightSpaceToView(self.contentView, 0).heightIs(1);
//        dipLabel.backgroundColor = [UIColor lightGrayColor];
        
        [self setupAutoHeightWithBottomView:self.cotentLabel bottomMargin:10];
        
        
    }
    return self;
}
//-(void)layoutSubviews{
//    NSString *str = [NSString stringWithFormat:@"http://xf.vqune.com%@",self.model.UserPic];
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
//    self.nameLabel.text = self.model.UserName;
//    self.timeLabel.text = self.model.C_Intime;
//    self.cotentLabel.text = self.model.C_Content;
// 
//}
-(void)setModel:(GetCommentListModel *)model{

    _model = model;
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,_model.UserPic];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
    self.nameLabel.text = _model.UserName;
    self.timeLabel.text = _model.C_Intime;
    self.cotentLabel.text = _model.C_Content;
}
@end
