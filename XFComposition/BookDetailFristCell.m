//
//  BookDetailFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookDetailFristCell.h"
@interface BookDetailFristCell()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;
@property (nonatomic,strong)UILabel *label5;
@property (nonatomic,strong)UILabel *label6;
@property (nonatomic,strong)UILabel *label7;
@property (nonatomic,strong)UILabel *label8;

@property (nonatomic,strong)UIButton *bt1;
@property (nonatomic,strong)UIButton *bt2;
@property (nonatomic,strong)UIButton *bt3;

@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *neirongLabel;
@end
@implementation BookDetailFristCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgView];
        self.imgView.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 5).heightIs(135).widthIs(100);
        
        UILabel *jianjieLabel = [[UILabel alloc]init];
        [self.contentView addSubview:jianjieLabel];
        jianjieLabel.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.imgView, 5).autoHeightRatio(0).widthIs(0);
        [jianjieLabel setSingleLineAutoResizeWithMaxWidth:0];
        jianjieLabel.text = @"简 介：";

        jianjieLabel.font = [UIFont systemFontOfSize:12];
        
        self.neirongLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.neirongLabel];
        self.neirongLabel.sd_layout.leftSpaceToView(jianjieLabel, 0).topEqualToView(jianjieLabel).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
        self.neirongLabel.font = [UIFont systemFontOfSize:12];
//        self.neirongLabel.text = @"wooa dd我哦owowowowowslslslsldldll喔喔老来对开始看大佬收留聊得来的了算了的了算了大佬收留点睡了来电铃声累死了德累斯顿了算了的了算了的累死了水利电力水利电力 ";
        
        [self setupAutoHeightWithBottomView:self.neirongLabel bottomMargin:30];
        
        
        self.titleLabel = [[UILabel alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.label4 = [[UILabel alloc]init];
        self.label5 = [[UILabel alloc]init];
        
        UILabel *shuLabel1 = [[UILabel alloc]init];
        UILabel *shuLabel2 = [[UILabel alloc]init];
        self.label6 = [[UILabel alloc]init];
        self.label7 = [[UILabel alloc]init];
        self.label8 = [[UILabel alloc]init];
        
        self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        [self.contentView sd_addSubviews:@[self.titleLabel,self.label1,self.label2,self.label3,self.label4,self.self.label5,self.label6,self.label7,self.label8,self.bt1,self.bt2,self.bt3,shuLabel1,shuLabel2]];
        
        self.titleLabel.sd_layout.leftSpaceToView(self.imgView, 15).topSpaceToView(self.contentView, 10).heightIs(30).widthIs(0);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.titleLabel.font = [UIFont systemFontOfSize:14];

        
        self.label1.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.titleLabel, 2).heightIs(15).widthIs(0);
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
        self.label1.font = [UIFont systemFontOfSize:12];
        self.label1.text = @"热  度：";
        
        self.label2.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.label1, 2).heightIs(15).widthIs(0);
        [self.label2 setSingleLineAutoResizeWithMaxWidth:0];
        self.label2.font = [UIFont systemFontOfSize:12];
        self.label2.text = @"作  者：";
        
        self.label3.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.label2, 2).heightIs(15).widthIs(0);
        [self.label3 setSingleLineAutoResizeWithMaxWidth:0];
        self.label3.font = [UIFont systemFontOfSize:12];
        self.label3.text = @"出版社：";
        
        
        self.label4.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.label3, 2).heightIs(15).widthIs(0);
        [self.label4 setSingleLineAutoResizeWithMaxWidth:0];
        self.label4.font = [UIFont systemFontOfSize:12];
        self.label4.text = @"出版日期：";
        
        self.label5.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.label4, 2).heightIs(15).widthIs(0);
        [self.label5 setSingleLineAutoResizeWithMaxWidth:0];
        self.label5.font = [UIFont systemFontOfSize:12];
        self.label5.text = @"总页数：";
        
        self.bt1.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.label5, 5).heightIs(25).widthIs(40);
        [self.bt1 setTitle:@"想读" forState:UIControlStateNormal];
        self.bt1.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.bt1 setBackgroundColor:[UIColor colorWithHexString:@"3690CE"]];
        self.bt1.layer.cornerRadius=4;
        self.bt1.layer.masksToBounds = YES;
        self.bt1.tag = 1000;
        [self.bt1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
        
        self.bt2.sd_layout.leftSpaceToView(self.bt1, 20).topSpaceToView(self.label5, 5).heightIs(25).widthIs(40);
        [self.bt2 setTitle:@"在读" forState:UIControlStateNormal];
        self.bt2.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.bt2 setBackgroundColor:[UIColor colorWithHexString:@"46A4C6"]];
        self.bt2.layer.cornerRadius=4;
        self.bt2.layer.masksToBounds = YES;
        self.bt1.tag = 1001;
        [self.bt2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
        
        self.bt3.sd_layout.leftSpaceToView(self.bt2, 20).topSpaceToView(self.label5, 5).heightIs(25).widthIs(40);
        [self.bt3 setTitle:@"已读" forState:UIControlStateNormal];
        self.bt3.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.bt3 setBackgroundColor:[UIColor colorWithHexString:@"D99E3F"]];
        self.bt3.layer.cornerRadius=4;
        self.bt3.layer.masksToBounds = YES;
        self.bt1.tag = 1002;
        [self.bt3 addTarget:self action:@selector(click3) forControlEvents:UIControlEventTouchUpInside];
        
        self.label6.sd_layout.leftSpaceToView(self.label1, 2).topEqualToView(self.label1).heightIs(15).widthIs(0);
        [self.label6 setSingleLineAutoResizeWithMaxWidth:0];
        self.label6.font = [UIFont systemFontOfSize:12];
        
        shuLabel1.sd_layout.leftSpaceToView(self.label6, 2).topEqualToView(self.label1).heightIs(15).widthIs(1);
        shuLabel1.backgroundColor = [UIColor colorWithHexString:@"539CD3"];
        
        self.label7.sd_layout.leftSpaceToView(shuLabel1, 2).topEqualToView(self.label1).heightIs(15).widthIs(0);
        [self.label7 setSingleLineAutoResizeWithMaxWidth:0];
        self.label7.font = [UIFont systemFontOfSize:12];
        
        shuLabel2.sd_layout.leftSpaceToView(self.label7, 2).topEqualToView(self.label1).heightIs(15).widthIs(1);
        shuLabel2.backgroundColor = [UIColor colorWithHexString:@"539CD3"];
        
        self.label8.sd_layout.leftSpaceToView(shuLabel2, 2).topEqualToView(self.label1).heightIs(15).widthIs(0);
        [self.label8 setSingleLineAutoResizeWithMaxWidth:0];
        self.label8.font = [UIFont systemFontOfSize:12];

    }
    return self;
}
-(void)layoutSubviews{
    
}

-(void)setModel:(GetBookInfoModel *)model{
    
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"《%@》",_model.bookname];
    self.label2.text = [NSString stringWithFormat:@"作   者：%@",_model.bookauthor];
    self.label3.text = [NSString stringWithFormat:@"出 版 社：%@",_model.bookpublish];
    self.label4.text = [NSString stringWithFormat:@"出版日期：%@",_model.bookpublish];
    self.label5.text = [NSString stringWithFormat:@"总 页 数：%@",_model.bookpages];
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,_model.bookpic];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
    self.neirongLabel.text =self.model.bookinfo;
    
    self.label6.text = [NSString stringWithFormat:@"想读%@人",_model.wandread];
    self.label7.text = [NSString stringWithFormat:@"在读%@人",_model.currentread];
    self.label8.text = [NSString stringWithFormat:@"已读%@人",_model.finishread];
}


-(void)click1{
    if ([self.delegate respondsToSelector:@selector(wantRead)]) {
        [self.delegate wantRead];
    }
}
-(void)click2{
    if ([self.delegate respondsToSelector:@selector(NowRead)]) {
        [self.delegate NowRead];
    }
}
-(void)click3{
    if ([self.delegate respondsToSelector:@selector(PastRead)]) {
        [self.delegate PastRead];
    }
    
}
@end
