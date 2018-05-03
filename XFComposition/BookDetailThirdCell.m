//
//  BookDetailThirdCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookDetailThirdCell.h"
@interface BookDetailThirdCell()


@property (nonatomic,strong)UILabel *neirongLael;
@property (nonatomic,strong)UIButton *bt;
@property (nonatomic,strong)UILabel *numLabel;
@end
@implementation BookDetailThirdCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]init];
        self.titleLabel = [[UILabel alloc]init];
        self.neirongLael = [[UILabel alloc]init];
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView *renImgView = [[UIImageView alloc]init];
        renImgView.image = [UIImage imageNamed:@"icon_canjia"];
        self.numLabel = [[UILabel alloc]init];
        
        [self.contentView sd_addSubviews:@[self.imgView,self.titleLabel,self.neirongLael,self.bt,renImgView,self.numLabel]];
        
        self.imgView.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 10).widthIs(WidthFrame/3).heightIs(80);
    
        self.titleLabel.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.contentView, 10).heightIs(30).widthIs(0);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.titleLabel.text = @"测试图书读书测试";
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        self.neirongLael.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.titleLabel, 5).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
        self.neirongLael.text = @"内容";
        self.neirongLael.font = [UIFont systemFontOfSize:12];
        
        self.bt.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.neirongLael, 15).widthIs(50).heightIs(30);
        [self.bt setTitle:@"参与" forState:UIControlStateNormal];
        [self.bt addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
        self.bt.layer.cornerRadius = 4;
        self.bt.layer.masksToBounds = YES;
        self.bt.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.bt setBackgroundColor:[UIColor colorWithHexString:@"3691CE"]];
        
        renImgView.sd_layout.leftSpaceToView(self.bt, 5).topSpaceToView(self.neirongLael, 17).heightIs(30).widthIs(30);
//        renImgView.backgroundColor = [UIColor lightGrayColor];
        self.numLabel.sd_layout.leftSpaceToView(renImgView, 2).topSpaceToView(self.neirongLael, 25).widthIs(0);
        [self.numLabel setSingleLineAutoResizeWithMaxWidth:0];
        
        self.numLabel.font = [UIFont systemFontOfSize:12];
        
        [self setupAutoHeightWithBottomView:self.bt bottomMargin:20];
        
        
        
    }
    return self;
}

-(void)click{
    if ([self.delegate respondsToSelector:@selector(canyu)]) {
        [self.delegate canyu];
    }
}
-(void)layoutSubviews{
    
}

-(void)setModel:(GetSubejectModel *)model{
    _model = model;
    self.numLabel.text = [NSString stringWithFormat:@"%@人参与",_model.joinnum];
    self.neirongLael.text = [NSString stringWithFormat:@"题库中共有题目%@个，系统将自动出题，测试不限制字数",_model.subjectnum];
}
@end
