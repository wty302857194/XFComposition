//
//  HomePageClassroomTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePageClassroomTableViewCell.h"
@interface HomePageClassroomTableViewCell ()

@end
@implementation HomePageClassroomTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        

    }
    return self;
}
-(void)layoutSubviews{
    CGFloat btW = (WidthFrame-20*3)/5*2;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 5, WidthFrame - 40, 100)];
    scrollView.contentSize = CGSizeMake((btW+20)*self.lableArray.count, 80);
    scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i<self.lableArray.count; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//        [bt setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [bt setBackgroundImage:[UIImage imageNamed:@"XFKe1"] forState:UIControlStateNormal];
        [bt setBackgroundColor:[UIColor lightGrayColor]];
        [bt setTitle:@"" forState:UIControlStateNormal];
        bt.tag = 2000+i;
        bt.frame = CGRectMake(btW*i+20*i, 0, btW, 80);
        [scrollView addSubview:bt];
        
        UILabel *dipLabel = [[UILabel alloc]init];
        dipLabel.text = self.lableArray[i];
        dipLabel.font = [UIFont systemFontOfSize:12];
        dipLabel.tag = 1000+i;
        dipLabel.frame = CGRectMake(btW*i+20 *i, 80, btW, 20);
        dipLabel.textAlignment = NSTextAlignmentCenter;
        [scrollView addSubview:dipLabel];
    }
    
    
    [self.contentView addSubview:scrollView];

}
-(void)setClassArray:(NSArray *)classArray{
    _classArray = classArray;
    
}
-(void)setLableArray:(NSArray *)lableArray{

    _lableArray = lableArray;
}
-(void)click:(UIButton *)bt{
    NSLog(@"%ld",(long)bt.tag);
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
