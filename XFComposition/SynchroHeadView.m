//
//  SynchroHeadView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "SynchroHeadView.h"
@interface SynchroHeadView ()
@property (nonatomic,strong)NSArray *classArray;
@property (nonatomic,strong)NSArray *nameArray;
@property (nonatomic,strong)NSArray *gradeArray;
@end
@implementation SynchroHeadView
-(NSArray *)classArray{
    if (!_classArray) {
        _classArray = @[@"所有课程",@"即将进行",@"正在进行",@"结束课程"];
    }
    return _classArray;
}
-(NSArray *)nameArray{
    if (!_nameArray) {
        _nameArray = @[@"全部",@"叙事",@"写景",@"写人",@"日志"];
    }
    return _nameArray;
}
-(NSArray *)gradeArray{
    if (!_gradeArray) {
        _gradeArray = @[@"全部",@"一年级",@"二年级",@"三年级"];
    }
    return _gradeArray;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor lightGrayColor];
        int z =1000;
        int m =2000;
        int n =3000;
        for (int i = 0; i<4; i++) {
            UIButton *Timebt = [[UIButton alloc]initWithFrame:CGRectMake(60+(60+30)*i, 10, 60, 40)];
            Timebt.tag = z;
            [Timebt addTarget:self action:@selector(classClick:) forControlEvents:UIControlEventTouchUpInside];
            Timebt.titleLabel.font = [UIFont systemFontOfSize:12];
            Timebt.layer.cornerRadius = 6;
            Timebt.clipsToBounds = YES;
            Timebt.backgroundColor = UIColorFromRGBA(30, 144, 255, 1.0f);
            Timebt.titleLabel.adjustsFontSizeToFitWidth = YES;
            [Timebt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [Timebt setTitle:self.classArray[i] forState:UIControlStateNormal];
            

            [self addSubview:Timebt];
            z++;
        }
        for (int i = 0; i<5; i++) {
            UIButton *Namebt = [[UIButton alloc]initWithFrame:CGRectMake(60+(40+5)*i, 10+50, 40, 40)];
            Namebt.tag = m;
            [Namebt addTarget:self action:@selector(classClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [Namebt setTitle:self.nameArray[i] forState:UIControlStateNormal];
            [self addSubview:Namebt];
            m++;
        }
        for (int i = 0; i<4; i++) {
            UIButton *Gradebt = [[UIButton alloc]initWithFrame:CGRectMake(60+(60+5)*i, 110, 60, 40)];
            Gradebt.tag = n;
            [Gradebt addTarget:self action:@selector(classClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [Gradebt setTitle:self.gradeArray[i] forState:UIControlStateNormal];
            [self addSubview:Gradebt];
            n++;
        }

        
    }
    return self;
}
-(void)classClick:(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(choosePag:)]) {
        [self.delegate choosePag:bt];
    }

}
@end
