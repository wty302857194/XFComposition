//
//  ReadnoteTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadnoteTableViewCell.h"
@interface ReadnoteTableViewCell()
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *titileLabel;
@property (nonatomic,strong)UILabel *timeLable;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;


@end
@implementation ReadnoteTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]init];
        self.titileLabel = [[UILabel alloc]init];
        self.timeLable = [[UILabel alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView *line_Img = [[UIImageView alloc] init];
        
        [self.contentView sd_addSubviews:@[line_Img,self.imgView,self.titileLabel,self.timeLable,self.label1,self.label2,self.label3,self.bt]];
        
        self.imgView.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 10).widthIs(60).heightIs(80);
        self.imgView.layer.cornerRadius = 6;
        self.imgView.layer.masksToBounds = YES;
        
        self.titileLabel.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.contentView, 10).heightIs(30).widthIs(0);
        [self.titileLabel setSingleLineAutoResizeWithMaxWidth:WidthFrame/2];
        self.titileLabel.font = [UIFont systemFontOfSize:15];
        
        
        self.timeLable.sd_layout.rightSpaceToView(self.imgView, 20).topSpaceToView(self.contentView, 9).heightIs(20).widthIs(0);
        [self.timeLable setSingleLineAutoResizeWithMaxWidth:0];
        self.timeLable.font = [UIFont systemFontOfSize:11];
        self.timeLable.textColor = [UIColor colorWithHexString:@"6C6E6E"];
        
        line_Img.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.titileLabel, 5).heightIs(1).rightSpaceToView(self.contentView, 20);
        line_Img.image = [UIImage imageNamed:@"xuxian"];
        
        self.label1.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(line_Img, 5).heightIs(20).widthIs(0);
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
        self.label1.font = [UIFont systemFontOfSize:12];
        self.label1.textColor = [UIColor colorWithHexString:@"6C6E6E"];
        
        self.label2.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.label1, 5).heightIs(20).widthIs(0);
        [self.label2 setSingleLineAutoResizeWithMaxWidth:0];
        self.label2.font = [UIFont systemFontOfSize:12];
        self.label2.textColor = [UIColor colorWithHexString:@"6C6E6E"];
        self.label3.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.label2, 5).heightIs(20).widthIs(0);
        [self.label3 setSingleLineAutoResizeWithMaxWidth:0];
        self.label3.font = [UIFont systemFontOfSize:12];
        self.label3.textColor = [UIColor colorWithHexString:@"6C6E6E"];
        
        self.bt.sd_layout.rightSpaceToView(self.contentView, 40).topSpaceToView(line_Img, 20).widthIs(40).heightIs(30);
        [self.bt setTitle:@"评论" forState:UIControlStateNormal];
        self.bt.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.bt setBackgroundColor:[UIColor lightGrayColor]];
        self.bt.titleLabel.textColor = [UIColor colorWithHexString:@"6C6E6E"];
        [self.bt addTarget:self action:@selector(pinglun:) forControlEvents:UIControlEventTouchUpInside];
        //  没有 图片
    }
    return self;
}
-(void)pinglun:(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(comment :)]) {
        [self.delegate comment:bt];
    }

}
-(void)setModel:(GetBookBjModel *)model{

    _model = model;
    NSString *str = [NSString stringWithFormat:@"%@",_model.bookpic];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
    self.titileLabel.text = _model.title;
    self.timeLable.text = _model.addtime;
    self.label1.text = [NSString stringWithFormat:@"用户名：%@",_model.username];
    self.label2.text = [NSString stringWithFormat:@"学  校：%@",_model.deptname];
    self.label3.text = [NSString stringWithFormat:@"图  书：%@",_model.bookname];
}
@end
