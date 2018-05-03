//
//  HomePaFiveCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePaFiveCell.h"
#import "WriteListModel.h"
@implementation HomePaFiveCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat btW = (WidthFrame-30-20*2)/3;
        //    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame , 100)];
        //    scrollView.contentSize = CGSizeMake((btW+20)*(self.lableArray.count+1), 100);
        //    scrollView.showsHorizontalScrollIndicator = NO;
        
        
        
        //        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        //        [bt setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        //        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str]];
        //        [bt.ba sd_setImageWithURL:[NSURL URLWithString:str]];
        //        [bt setBackgroundImage:[UIImage imageNamed:@"XFKe1"] forState:UIControlStateNormal];
        //        [bt setBackgroundColor:[UIColor lightGrayColor]];
        //        [bt setTitle:@"" forState:UIControlStateNormal];
        //        bt.tag = 2000+i;
        //        bt.frame = CGRectMake(btW*i+20*i, 0, btW, 80);
        //        [self addSubview:bt];
        
        _image = [[UIImageView alloc]init];
        _image.frame = CGRectMake(0, 0, btW, 80);
        
        [self.contentView addSubview:_image];
        
        
        _dipLabel = [[UILabel alloc]init];
        
        _dipLabel.font = [UIFont systemFontOfSize:12];
        
        _dipLabel.frame = CGRectMake(10 , 80, btW, 20);
        _dipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dipLabel];
    }
    return self;
}



//-(void)setClassArray:(NSArray *)classArray{
//    _classArray = classArray;
//
//}
//-(void)setLableArray:(NSArray *)lableArray{
//
//    _lableArray = lableArray;
//}
-(void)click:(UIButton *)bt{
    NSLog(@"%ld",(long)bt.tag);
    
}
@end
