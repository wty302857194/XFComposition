//
//  SubmissiontableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "SubmissiontableViewCell.h"

@implementation SubmissiontableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"E8F2FA"];
        self.titleLabel = [[UILabel alloc]init];
        self.studentLabel = [[UILabel alloc]init];
        self.activityLabel = [[UILabel alloc]init];
        self.timeLabel = [[UILabel alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        UILabel *label4 = [[UILabel alloc]init];
        UILabel *label5 = [[UILabel alloc]init];
        UILabel *label6 = [[UILabel alloc]init];
        UILabel *jglabel1 = [[UILabel alloc]init];
        UILabel *jglabel2 = [[UILabel alloc]init];
        UIImageView *xxView = [[UIImageView alloc]init];
        
        UIImageView *backView = [[UIImageView alloc]init];
        [backView sd_addSubviews:@[self.titleLabel,self.studentLabel,self.activityLabel,self.timeLabel,self.label1,self.label2,self.label3,label4,label5,label6,xxView,jglabel1,jglabel2]];
        [self.contentView addSubview:backView];
        backView.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
        backView.image = [UIImage imageNamed: @"bg_dashubiji"];
        backView.userInteractionEnabled = YES;
        
        self.titleLabel.text = @"《疯狂阅读》";
        self.titleLabel.sd_layout.leftSpaceToView(backView, 0).topSpaceToView(backView, 0).heightIs(30).widthIs(WidthFrame-40);
        [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"66B3DE"];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        CGFloat w = (WidthFrame-40)/3;
        self.studentLabel.sd_layout.leftSpaceToView(backView, 0).topSpaceToView(self.titleLabel, 5).heightIs(15).widthIs(w);
        self.studentLabel.text = @"student";
        self.studentLabel.font = [UIFont systemFontOfSize:10];
        self.studentLabel.textAlignment = NSTextAlignmentCenter;
        self.studentLabel.textColor = [UIColor colorWithHexString:@"66B3DE"];
        self.activityLabel.sd_layout.leftSpaceToView(self.studentLabel, 0).topSpaceToView(self.titleLabel, 5).heightIs(15).widthIs(w);
        self.activityLabel.text = @"中秋节活动";
        
        self.activityLabel.font = [UIFont systemFontOfSize:10];
        self.activityLabel.textAlignment = NSTextAlignmentCenter;
        self.activityLabel.textColor = [UIColor colorWithHexString:@"66B3DE"];
        self.timeLabel.sd_layout.leftSpaceToView(self.activityLabel, 0).topSpaceToView(self.titleLabel, 5).heightIs(15).widthIs(w);
        self.timeLabel.text = @"2017~08~09";
        self.timeLabel.font = [UIFont systemFontOfSize:10];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.textColor = [UIColor colorWithHexString:@"66B3DE"];
        
        
        xxView.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(self.activityLabel, 5).heightIs(2).widthIs(WidthFrame-80);
        xxView.image = [UIImage imageNamed:@"xuxian"];
        self.label1.sd_layout.leftSpaceToView(backView, 0).topSpaceToView(xxView, 5).heightIs(15).widthIs(w);
        self.label1.text = @"入库";
        [self.label1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        self.label1.textAlignment = NSTextAlignmentCenter;
        
        jglabel1.sd_layout.leftSpaceToView(self.label1, 0).topSpaceToView(xxView, 2).heightIs(31).widthIs(1);
        jglabel1.backgroundColor = [UIColor lightGrayColor];
        self.label2.sd_layout.leftSpaceToView(jglabel1, 0).topSpaceToView(xxView, 5).heightIs(15).widthIs(w);
        self.label2.text = @"未点评";
        [self.label2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        self.label2.textAlignment = NSTextAlignmentCenter;
        jglabel2.sd_layout.leftSpaceToView(self.label2, 0).topSpaceToView(xxView, 2).heightIs(31).widthIs(1);
        jglabel2.backgroundColor = [UIColor lightGrayColor];
        
        
        self.label3.sd_layout.leftSpaceToView(jglabel2, 0).topSpaceToView(xxView, 5).heightIs(15).widthIs(w);
        self.label3.text = @"已审核";
        [self.label3 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        self.label3.textAlignment = NSTextAlignmentCenter;
        
        
        label4.sd_layout.leftSpaceToView(backView, 0).topSpaceToView(self.label1, 5).heightIs(15).widthIs(w);
        label4.text = @"审核状态";
        label4.textAlignment = NSTextAlignmentCenter;
        label4.font = [UIFont systemFontOfSize:9];
        label5.sd_layout.leftSpaceToView(jglabel1, 0).topSpaceToView(self.label2, 5).heightIs(15).widthIs(w);
        label5.text = @"是否点评";
        label5.textAlignment = NSTextAlignmentCenter;
        label5.font = [UIFont systemFontOfSize:9];
        label6.sd_layout.leftSpaceToView(jglabel2, 0).topSpaceToView(self.label3, 5).heightIs(15).widthIs(w);
        label6.text = @"是否评审";
        label6.font = [UIFont systemFontOfSize:9];
        label6.textAlignment = NSTextAlignmentCenter;
        
        [backView setupAutoHeightWithBottomView:label4 bottomMargin:5];
        [self setupAutoHeightWithBottomView:backView bottomMargin:5];
        
    }
    return self;
}
-(void)setModel:(ActiveWriteListModel *)model{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"《%@》",_model.ActiveItemName];
    self.studentLabel.text = _model.WriteUserName;
    self.activityLabel.text = _model.BlogTitle;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@",_model.AddTime];
    self.label1.text = _model.WriteCheckStatic;
    if (_model.IsCheck == 0) {
        self.label2.text = @"未点评";
    }else{
        self.label2.text = @"已点评";
    }
    
    if (_model.TeacherStart == 0) {
        self.label3.text = @"未评审";
    }else {
        self.label3.text = @"已评审";
    }


}

@end
