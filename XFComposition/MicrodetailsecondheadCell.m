//
//  MicrodetailsecondheadCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/15.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicrodetailsecondheadCell.h"

@implementation MicrodetailsecondheadCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 2)];;
        label.backgroundColor = [UIColor colorWithHexString:@"C0C1C5"];
        [self addSubview:label];
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 2, WidthFrame , 38)];
        [self addSubview:scrollView];
        self.tabBtnArray = [[NSMutableArray alloc]init];
        
        NSArray *array = @[@"课程大纲",@"写片段",@"写作文",@"课程交流",@"本课习作",@"公益点评"];
        scrollView.showsHorizontalScrollIndicator = NO;
        CGFloat z= 0.0;
        for (int i = 0; i<array.count; i++) {
            
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            bt.backgroundColor = UIColorFromRGBA(30, 144, 255, 1.0f);
            [bt setTitle:array[i] forState:UIControlStateNormal];
            bt.layer.cornerRadius = 6;
            bt.clipsToBounds = YES;
            bt.tag = 1000+i;
            
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            bt.titleLabel.font = [UIFont systemFontOfSize:13.0];
            CGSize titleSize = [array[i] sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:bt.titleLabel.font.fontName size:bt.titleLabel.font.pointSize]}];
            
            
            titleSize.width +=20;
            CGFloat flo = titleSize.width;
            
            
            
            bt.frame = CGRectMake(20+z, 5, titleSize.width, 30);
            z= flo +z+15;
            
            scrollView.contentSize = CGSizeMake((titleSize.width+30)*(array.count), 38);
            [scrollView addSubview:bt];
            [self.tabBtnArray addObject:bt];
            if (i == 0) {
                [bt setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
            }
        }

    }
    
    return self;
}
-(void)click:(UIButton *)bt{
    
    if ([self.delegate respondsToSelector:@selector(srollView:)]) {
        [self.delegate srollView:bt];
    }
}

@end
