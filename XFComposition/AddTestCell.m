//
//  AddTestCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "AddTestCell.h"

@interface AddTestCell()
@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;
@end
@implementation AddTestCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.label4 = [[UILabel alloc]init];
        UILabel *jgLable1 = [[UILabel alloc]init];
        UILabel *jgLable2 = [[UILabel alloc]init];
        UIImageView *bgimgView = [[UIImageView alloc]init];
        self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.joinbt = [[UILabel alloc]init];
        self.bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *checkbt = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor whiteColor];
        [backView sd_addSubviews:@[self.titleLabel,self.label3,self.label4,self.bt1,self.joinbt,self.bt2,jgLable1,jgLable2,bgimgView,checkbt]];
        [self.contentView addSubview:backView];
        
        backView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 0).autoHeightRatio(0);
        
        self.titleLabel.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(backView, 5).heightIs(35).widthIs(WidthFrame/3*2);
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        
        self.bt1.sd_layout.rightSpaceToView(backView, 40).topSpaceToView(backView, 0).heightIs(20).widthIs(20);
        
        [self.bt1 addTarget:self action:@selector(buttonClick :) forControlEvents:UIControlEventTouchUpInside];
        
        self.joinbt.sd_layout.rightSpaceToView(backView, 20).topSpaceToView(self.bt1, 0).heightIs(20).widthIs(0);
        
        self.joinbt.font = [UIFont systemFontOfSize:12];
        [self.joinbt setSingleLineAutoResizeWithMaxWidth:0];

        
        
        bgimgView.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(self.joinbt, 5).widthIs(WidthFrame-40).heightIs(.5);
        bgimgView.image = [UIImage imageNamed:@"xuxian"];
        
        CGFloat w = (WidthFrame-40)/3;
        
        self.label3.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(bgimgView, 0).heightIs(40).widthIs(w);
        self.label3.textAlignment = NSTextAlignmentCenter;
        self.label3.font = [UIFont systemFontOfSize:14];
        
        jgLable1.sd_layout.leftSpaceToView(self.label3, 0).topSpaceToView(bgimgView, 10).heightIs(20).widthIs(.5);
        jgLable1.backgroundColor = hexColor(e5e5e6);
        self.label4.sd_layout.leftSpaceToView(jgLable1, 0).topSpaceToView(bgimgView, 0).heightIs(40).widthIs(w);
        self.label4.textAlignment = NSTextAlignmentCenter;
        self.label4.font = [UIFont systemFontOfSize:14];

        
        jgLable2.sd_layout.leftSpaceToView(self.label4, 0).topSpaceToView(bgimgView, 10).heightIs(20).widthIs(.5);
        jgLable2.backgroundColor = hexColor(e5e5e5);
        
        
        checkbt.sd_layout.leftSpaceToView(jgLable2, 8).topSpaceToView(bgimgView, 10).heightIs(20).widthIs(80);

        [checkbt setImage :[UIImage imageNamed:@"icon_shanchu"] forState:UIControlStateNormal];
        [checkbt addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
        [checkbt setTitle:@"  查看" forState:UIControlStateNormal];
        checkbt.titleLabel.font = [UIFont systemFontOfSize:14];
        [checkbt setTitleColor:[UIColor colorWithHexString:@"9A9B9A"] forState:UIControlStateNormal];
        
        [backView setupAutoHeightWithBottomView:self.label3 bottomMargin:0];
        [self setupAutoHeightWithBottomView:backView bottomMargin:5];
    }
    return self;
}
-(void)buttonClick :(UIButton *)bt{
//    bt.selected = !bt.selected;
    if ([self.delegate respondsToSelector:@selector(gengxinnimabi:)]) {
        [self.delegate gengxinnimabi:bt];
    }
}
-(void)check:(UIButton *)bt{
    if ([self.delegate respondsToSelector: @selector(chakan: withModel:)]) {
        [self.delegate chakan:bt withModel:_model];
    }
    
}
-(void)setModel:(GetMyPageSubjectListModel *)model{
    _model = model;
    self.titleLabel.text = _model.SubjectTitle;
    self.label3.text = [NSString stringWithFormat:@"ID：%@",_model.SubjectID];
    if (_model.SubjectType  == 1) {
        self.label4.text = @"单选题";
    }else if (_model.SubjectType  == 2){
        self.label4.text = @"多选题";

    }else if (_model.SubjectType  == 3){
        self.label4.text = @"判选题";

    }else if (_model.SubjectType  == 4){
        self.label4.text = @"问答题";

    }else if (_model.SubjectType  == 5){
        self.label4.text = @"填空题";
    }
    
}
@end
