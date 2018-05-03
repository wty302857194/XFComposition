//
//  RingdetailHeadView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RingdetailHeadView.h"

@implementation RingdetailHeadView
-(NSArray *)btArray{
    if (!_btArray) {
        _btArray = @[@"全部",@"新鲜事",@"教师作业",@"微课",@"阅读检测",@"教学",@"活动"];
    }
    return _btArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor colorWithHexString:@"#F5DEB3"];
        _tabBtnArray = [[NSMutableArray alloc]init];
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame , 40)];
        
        scrollView.showsHorizontalScrollIndicator = NO;
        CGFloat z= 0.0;
        for (int i = 0; i<self.btArray.count; i++) {
            
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [bt setTitle:self.btArray[i] forState:UIControlStateNormal];
            bt.tag = 2000+i;

            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            bt.titleLabel.font = [UIFont systemFontOfSize:13.0];
            CGSize titleSize = [self.btArray[i] sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:bt.titleLabel.font.fontName size:bt.titleLabel.font.pointSize]}];
            

            titleSize.width +=20;
            CGFloat flo = titleSize.width;
            
            

            bt.frame = CGRectMake(20+z, 0, titleSize.width, 40);
            z= flo +z+15;
            
            scrollView.contentSize = CGSizeMake((titleSize.width+30)*(self.btArray.count+1), 40);
            [scrollView addSubview:bt];
            [_tabBtnArray addObject:bt];
            if (i == 0) {
                [bt setTitleColor: UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
            }
        }
        
        
        [self addSubview:scrollView];

    }
    return self;
}
-(void)click:(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(scrollrRingView:)]) {
        [self.delegate scrollrRingView:bt];
    }

}
@end
