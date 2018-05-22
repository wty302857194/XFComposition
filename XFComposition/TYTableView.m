//
//  TYTableView.m
//  XFComposition
//
//  Created by wbb on 2018/4/27.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "TYTableView.h"

@implementation TYTableView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroundView = view;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100*170/227.f, 100)];
    imgView.center = view.center;
    imgView.image = [UIImage imageNamed:@"xf_Norecord"];
    [view addSubview:imgView];
}


@end
