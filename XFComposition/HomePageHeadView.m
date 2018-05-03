//
//  HomePageHeadView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePageHeadView.h"
@interface HomePageHeadView ()

@end

@implementation HomePageHeadView


-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;{
    if (self = [super initWithFrame:frame]) {
        UIView *headerView = [[UIView alloc] initWithFrame:frame];//
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *leftLable = [[UILabel alloc]init];
        leftLable.frame = CGRectMake(20, 2, 2, 16);
        leftLable.backgroundColor = UIColorFromRGBA(135, 206, 235, 1.0f);
        [headerView addSubview:leftLable];
//        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftLable.frame)+20, 2, 100, 16)];
        UILabel *textLable = [[UILabel alloc]init];
        [headerView addSubview:textLable];
        textLable.sd_layout.leftSpaceToView(leftLable, 20).topSpaceToView(headerView, 2).heightIs(16);
        [textLable setSingleLineAutoResizeWithMaxWidth:0];
        textLable.text = title;
        [textLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
        
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setTitle:@"更多" forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:12];
        [bt setBackgroundColor:UIColorFromRGBA(106, 154, 255, 1.0f)];
        bt.frame = CGRectMake(WidthFrame -40 -20, 4, 40, 16);
        [bt addTarget:self action:@selector(doMore) forControlEvents:UIControlEventTouchUpInside];
        bt.layer.cornerRadius = 6;
        bt.clipsToBounds=YES;
        [headerView addSubview:bt];
        [self addSubview:headerView];
    }
    return self;
}
-(void)doMore{

    NSLog(@"更多");

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
