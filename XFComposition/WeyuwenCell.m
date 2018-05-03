//
//  WeyuwenCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "WeyuwenCell.h"
@interface WeyuwenCell()
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UIButton *bt1;
@property (nonatomic,strong)UIButton *bt2;
@end
@implementation WeyuwenCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"E8F2FA"];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.imgView = [[UIImageView alloc]init];
        self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView *backView = [[UIView alloc]init];
        [backView sd_addSubviews:@[self.label1,self.label2,self.label3,self.imgView,self.bt1,self.bt2]];
        [self.contentView addSubview:backView];
        
        backView.backgroundColor = [UIColor whiteColor];
        backView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).autoHeightRatio(0);
        
        self.label1.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(backView, 20).rightSpaceToView(backView, 20).autoHeightRatio(0);
//        [self.label1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        self.label1.font = [UIFont systemFontOfSize:18];
        
        self.label2.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(self.label1, 20).heightIs(20).widthIs(0);
        self.label2.font = [UIFont systemFontOfSize:14];
        [self.label2 setSingleLineAutoResizeWithMaxWidth:0];
        
        self.imgView.sd_layout.leftSpaceToView(self.label2, 10).topSpaceToView(self.label1, 20).heightIs(20).widthIs(20);
        self.imgView.layer.masksToBounds = YES;
        self.imgView.layer.cornerRadius = 10;
        self.imgView.backgroundColor = [UIColor redColor];
        
        self.label3.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.label1, 20).heightIs(20).widthIs(0);
        self.label3.font = [UIFont systemFontOfSize:14];
        [self.label3 setSingleLineAutoResizeWithMaxWidth:0];
        
        self.bt2.sd_layout.rightSpaceToView(backView, 20).topEqualToView(self.label2).heightIs(20).widthIs(40);
//        [self.bt2 setTitle:@"测试" forState: UIControlStateNormal];
        [self.bt2 setImage:[UIImage imageNamed:@"icon_xiaoren00"] forState:UIControlStateNormal];
        [self.bt2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.bt2.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.bt2 setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        self.bt1.sd_layout.rightSpaceToView(backView, 70).topEqualToView(self.label2).heightIs(20).widthIs(40);
//        [self.bt1 setTitle:@"测试" forState: UIControlStateNormal];
        [self.bt1 setImage:[UIImage imageNamed:@"icon_liulan"] forState:UIControlStateNormal];
        [self.bt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.bt1.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.bt1 setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        [backView setupAutoHeightWithBottomView:self.label2 bottomMargin:5];
        [self setupAutoHeightWithBottomView:backView bottomMargin:2];
    }
    return self;
}
-(void)setModel:(GetDajiaListModel *)model{
    _model = model;
    NSString *str2 = [_model.NewsTitle stringByRemovingPercentEncoding];
    self.label1.text = [NSString stringWithFormat:@"%@",str2];
    self.label2.text = _model.Author;
    
    self.label3.text = _model.AddTime;
    [self.bt2 setTitle:[NSString stringWithFormat:@"%@",_model.CommentNum] forState: UIControlStateNormal];
    [self.bt1 setTitle:[NSString stringWithFormat:@"%@",_model.Click] forState: UIControlStateNormal];
}
@end
