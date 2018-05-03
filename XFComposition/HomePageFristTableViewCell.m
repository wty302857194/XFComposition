//
//  HomePageFristTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePageFristTableViewCell.h"
@interface HomePageFristTableViewCell ()
@property (nonatomic,strong)NSArray *buttonArray;
@end
@implementation HomePageFristTableViewCell

-(NSArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = @[@"作文库",@"微课堂",@"阅读与测评",@"志愿者活动",@"圈子",@"活动",@"大家点评",@"大家语文"];
    }
    return _buttonArray;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addsomeView];
    }
    return self;
}


-(void)addsomeView{
    CGFloat buttonW = (WidthFrame-40*5)/4;
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, (WidthFrame-20*5)/4*2+10+10)];
    backView.backgroundColor = [UIColor whiteColor];

    NSArray *array = @[@"icon1_zuowenku",@"icon2_weiketang",@"icon3_yuedu",@"icon4_zhiyuanzhe",@"icon5_quanzi",@"icon6_huodong",@"icon7_dianping",@"icon8_yuwen"];
    int z=0;
    
    for (int i=0; i<2; i++) {
        for (int j=0; j<4; j++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(40+(40+buttonW)*(j), 5+(30+buttonW)*(i), buttonW, buttonW);
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.tag = 1000+z;
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
//            [button setBackgroundImage:[UIImage imageNamed:array[z]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:array[z]] forState:UIControlStateNormal];

            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(30+(40+buttonW)*(j), 5+buttonW+5+(30+buttonW)*(i), buttonW+20, 20);
            label.tag = 2000+z;
            label.text = self.buttonArray[z];
            if (OSRetinaIs5inch) {
                label.font = [UIFont systemFontOfSize:11];
            }else {
            label.font = [UIFont systemFontOfSize:9];
            }
            label.textAlignment = NSTextAlignmentCenter;
            z++;
            [self.contentView addSubview:label];
            [self.contentView addSubview:button];
            
        }
    }

}
-(void)clickButton:(UIButton *)bt{
    NSLog(@"%ld",(long)bt.tag);
    
    if ([self.delegate respondsToSelector:@selector(Eightfunction:)]) {
        [self.delegate Eightfunction:bt];
    }
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
