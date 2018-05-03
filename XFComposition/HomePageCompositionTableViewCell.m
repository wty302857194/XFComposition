//
//  HomePageCompositionTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePageCompositionTableViewCell.h"
/****
 作文习作cell
 ****/

@interface HomePageCompositionTableViewCell ()
@property (nonatomic,strong)UIButton *bt;
@end
@implementation HomePageCompositionTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        
    }
    return self;
}

-(void)layoutSubviews{
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 5, WidthFrame - 40, 70)];
    scrollView.contentSize = CGSizeMake(((WidthFrame-20*4)/3+20)*self.compostitionArray.count, 70);
    scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i<self.compostitionArray.count; i++) {
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//        [self.bt setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.bt setBackgroundImage:[UIImage imageNamed:self.compostitionArray[i]] forState:UIControlStateNormal];
        [self.bt setBackgroundColor:[UIColor lightGrayColor]];
//        [self.bt setTitle:self.compostitionArray[i] forState:UIControlStateNormal];
        self.bt.tag = 2000+i;
        self.bt.frame = CGRectMake((WidthFrame-20*4)/3*i+20*i, 0, (WidthFrame-20*4)/3, 70);
        [scrollView addSubview:self.bt];
    }
    [self.contentView addSubview:scrollView];

    

}
-(void)setCompostitionArray:(NSArray *)compostitionArray{
    _compostitionArray = compostitionArray;
    
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
