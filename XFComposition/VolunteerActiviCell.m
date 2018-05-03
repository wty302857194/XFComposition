///Users/zhoufengxi/Desktop/XFComposition/XFComposition
//  VolunteerActiviCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/19.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "VolunteerActiviCell.h"

@implementation VolunteerActiviCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, WidthFrame/2-60, 90)];
        self.imgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imgView];
        
        self.titleLabel = [[UILabel alloc]init];
        self.timeLabel = [[UILabel alloc]init];
        self.xqlabel = [[UILabel alloc]init];
        self.textView = [[UITextView alloc]init];
        self.detailBt = [[UIButton alloc]init];
        
        [self sd_addSubviews:@[self.titleLabel,self.timeLabel,self.xqlabel,self.textView]];
        
        self.titleLabel.sd_layout.leftSpaceToView(self.imgView, 5).topSpaceToView(self, 5).heightIs(30);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:0];
//        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        self.titleLabel.text = @"wowwwwwwww";
        
        
        self.detailBt = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
//        self.detailBt.frame = CGRectMake(WidthFrame-90, 0, 80, 20);
//        [self.detailBt setTitle:@"查看活动详情" forState:UIControlStateNormal];
//        [self.detailBt addTarget:self action:@selector(lookDetail:) forControlEvents:UIControlEventTouchUpInside];
//        self.detailBt.layer.masksToBounds = YES;
//        self.detailBt.layer.cornerRadius = 6;
//        self.detailBt.layer.borderWidth = 1;
//        self.detailBt.layer.borderColor = [[UIColor colorWithHexString:@"e18f17"]CGColor];
//        [self.detailBt setTitleColor:[UIColor colorWithHexString:@"e18f17"] forState:UIControlStateNormal];
//        self.detailBt.titleLabel.font = [UIFont systemFontOfSize:10];
//        [self addSubview:self.detailBt];
//
        self.timeLabel.sd_layout.leftSpaceToView(self.imgView, 5).topSpaceToView(self.titleLabel, 5).heightIs(20);
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:0];
        
        self.timeLabel.font = [UIFont systemFontOfSize:10];
        self.timeLabel.text = @"202022222020";
        
        self.xqlabel.sd_layout.leftSpaceToView(self.imgView, 5).topSpaceToView(self.timeLabel, 10).heightIs(20);
        [self.xqlabel setSingleLineAutoResizeWithMaxWidth:0];
        self.xqlabel.font = [UIFont systemFontOfSize:10];
        self.xqlabel.text = @"活动详情:";

        
        self.textView.sd_layout.leftSpaceToView(self.xqlabel, 0).topSpaceToView(self.timeLabel, 1).widthIs(WidthFrame/2+40-10-self.xqlabel.width).heightIs(60);
        self.textView.font = [UIFont systemFontOfSize:10];
        self.textView.editable = NO;
        self.textView.text = @"wowowowocccc我";
        
//        self.teacherbt = [UIButton buttonWithType:UIButtonTypeSystem];
//        self.teacherbt.frame = CGRectMake(40, 100, WidthFrame/2-50, 25);
//        [self.teacherbt setTitle:@"申请成为志愿者老师" forState:UIControlStateNormal];
//        [self.teacherbt addTarget:self action:@selector(ApplyTeacher) forControlEvents:UIControlEventTouchUpInside];
//        self.teacherbt.backgroundColor = [UIColor colorWithHexString:@"389e98"];
//        self.teacherbt.layer.masksToBounds = YES;
//        [self.teacherbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.teacherbt.layer.cornerRadius = 6;
//        self.teacherbt.titleLabel.font = [UIFont systemFontOfSize:12];
//        [self addSubview:self.teacherbt];
//
//
//        self.workbt = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.workbt.frame = CGRectMake(WidthFrame/2+10, 100, WidthFrame/2-50, 25);
//        [self.workbt setTitle:@"申请工作" forState:UIControlStateNormal];
//        [self.workbt addTarget:self action:@selector(Applywork:) forControlEvents:UIControlEventTouchUpInside];
//        self.workbt.layer.masksToBounds = YES;
//        self.workbt.layer.cornerRadius = 6;
//        self.workbt.backgroundColor = [UIColor colorWithHexString:@"2791cf"];
//        self.workbt.titleLabel.font = [UIFont systemFontOfSize:12];
//        [self addSubview:self.workbt];
        
        
        
//        self.tougaobt = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.tougaobt.frame = CGRectMake(WidthFrame/4+25, 100, WidthFrame/2-50, 25);
//        [self.tougaobt setTitle:@"开始投稿" forState:UIControlStateNormal];
//        [self.tougaobt addTarget:self action:@selector(tougao) forControlEvents:UIControlEventTouchUpInside];
//        self.tougaobt.layer.masksToBounds = YES;
//        self.tougaobt.layer.cornerRadius = 6;
//        self.tougaobt.backgroundColor = [UIColor colorWithHexString:@"2791cf"];
//        self.tougaobt.titleLabel.font = [UIFont systemFontOfSize:12];
//        [self addSubview:self.tougaobt];

        
    }

    return self;
}
//-(void)lookDetail:(UIButton *)bt{
//    if ([self.delegate respondsToSelector:@selector(gotodetail:)]) {
//        [self.delegate gotodetail :bt];
//    }
//
//}
//-(void)ApplyTeacher{
//    if ([self.delegate respondsToSelector:@selector(Applyteacher)]) {
//        [self.delegate Applyteacher];
//    }
//
//}
//-(void)Applywork:(UIButton *)bt{
//    if ([self.delegate respondsToSelector:@selector(Applywork :)]) {
//        [self.delegate Applywork :bt];
//    }
//
//}
//-(void)tougao{
//    if ([self.delegate respondsToSelector:@selector(Submission)]) {
//        [self.delegate Submission];
//    }
//
//}
@end
