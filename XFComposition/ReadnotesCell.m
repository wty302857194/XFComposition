//
//  ReadnotesCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadnotesCell.h"
@interface ReadnotesCell()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *label1;

@end
@implementation ReadnotesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel = [[UILabel alloc]init];
        self.timeLabel = [[UILabel alloc]init];
        self.nameLabel = [[UILabel alloc]init];
        self.label1 = [[UILabel alloc]init];
        UIImageView *bgimgView = [[UIImageView alloc]init];
        UILabel *jgLable1 = [[UILabel alloc]init];
        self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *bt4 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView *backView = [[UIImageView alloc]init];
        [backView sd_addSubviews:@[self.titleLabel,self.nameLabel,self.timeLabel,self.label1,self.bt1,self.bt2,jgLable1,bgimgView,bt3,bt4]];
        [self.contentView addSubview:backView];
        
        backView.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
        backView.image = [UIImage imageNamed: @"bg_dashubiji"];
        backView.userInteractionEnabled = YES;
        self.titleLabel.sd_layout.leftSpaceToView(backView, 10).topSpaceToView(backView, 10).heightIs(40).widthIs(0);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:WidthFrame-60];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        
        self.titleLabel.textColor = [UIColor colorWithHexString:@"3995D1"];
        
        self.nameLabel.sd_layout.leftSpaceToView(backView, 10).topSpaceToView(self.titleLabel, 10).heightIs(20).widthIs(0);
        [self.nameLabel setSingleLineAutoResizeWithMaxWidth:(WidthFrame-20)/2-10];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = [UIColor colorWithHexString:@"9A9B9A"];
        self.timeLabel.sd_layout.leftSpaceToView(backView, (WidthFrame-20)/2).topSpaceToView(self.titleLabel, 10).heightIs(20).widthIs(0);
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.textColor = [UIColor colorWithHexString:@"9A9B9A"];
        
        self.label1.sd_layout.rightSpaceToView(backView, 20).topSpaceToView(self.titleLabel, 10).heightIs(20).widthIs(0);
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
        self.label1.textColor = hexColor(333333);
        self.label1.font = [UIFont systemFontOfSize:14];
        bgimgView.sd_layout.leftSpaceToView(backView, 10).topSpaceToView(self.timeLabel, 5).widthIs(WidthFrame-60).heightIs(.5);
        bgimgView.image = [UIImage imageNamed:@"xuxian"];
        CGFloat w = (WidthFrame-80)/4;
        self.bt1.sd_layout.leftSpaceToView(backView, w+3).topSpaceToView(bgimgView, 10).widthIs(15).heightIs(15);
        [self.bt1 setBackgroundImage:[UIImage imageNamed:@"icon_xiugai"] forState:UIControlStateNormal];
        [self.bt1 addTarget:self action:@selector(xiugaisomebj :) forControlEvents:UIControlEventTouchUpInside];
        
        bt3.sd_layout.leftSpaceToView(backView, w-10).topSpaceToView(self.bt1, 0).widthIs(40).heightIs(20);
        [bt3 setTitleColor:[UIColor colorWithHexString:@"9A9B9A"] forState:UIControlStateNormal];
        [bt3 setTitle:@"修改" forState:UIControlStateNormal];
        
        bt3.titleLabel.font = [UIFont systemFontOfSize:10];
        
        jgLable1.sd_layout.leftSpaceToView(backView, w*2 + 20).topSpaceToView(bgimgView, 5).widthIs(1).heightIs(40);
        jgLable1.backgroundColor = [UIColor lightGrayColor];
        
        self.bt2.sd_layout.leftSpaceToView(backView, w*3 + 23).topSpaceToView(bgimgView, 10).widthIs(15).heightIs(15);
        [self.bt2 setBackgroundImage:[UIImage imageNamed:@"icon_shanchu"] forState:UIControlStateNormal];
        [self.bt2 addTarget:self action:@selector(delesomebj :) forControlEvents:UIControlEventTouchUpInside];
        
        bt4.sd_layout.leftSpaceToView(backView,  w*3 + 10).topSpaceToView(self.bt2, 0).widthIs(40).heightIs(20);
        [bt4 setTitle:@"删除" forState:UIControlStateNormal];
        bt4.titleLabel.font = [UIFont systemFontOfSize:10];
        [bt4 setTitleColor:[UIColor colorWithHexString:@"9A9B9A"] forState:UIControlStateNormal];

        [backView setupAutoHeightWithBottomView:bt3 bottomMargin:2];
        [self setupAutoHeightWithBottomView:bt3 bottomMargin:10];
        
    }
    return  self;
}
-(void)xiugaisomebj :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(xiugaiBJ:)]) {
        [self.delegate xiugaiBJ:bt];
    }
}
-(void)delesomebj :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(delectBj:)]) {
        [self.delegate delectBj:bt];
    }

}
-(void)setModel:(GetBookBjListModel *)model{
    _model = model;
    self.titleLabel.text = _model.title;
    self.nameLabel.text = [NSString stringWithFormat:@"图书名称：《%@》",_model.bookname];
    self.timeLabel.text = [_model.addtime substringToIndex:9];
    if ([_model.bjstatic intValue] == 0) {
        self.label1.text = @"正常";
    }else{
        self.label1.text = @"不正常";
    }
    
    
}
-(void)setBookModel:(GetMybookListModel *)bookModel{
    _bookModel = bookModel;
    
    self.titleLabel.text = _bookModel.BookName;
    self.nameLabel.text = [NSString stringWithFormat:@"作者：《%@》",_bookModel.BookAuthor];
    self.timeLabel.text = [_bookModel.BookAddTime substringToIndex:9];
    if ([_bookModel.BookStatic intValue] == 0) {
        self.label1.text = @"尚未审核";
    }else{
        self.label1.text = @"已审核";
    }

}
@end
