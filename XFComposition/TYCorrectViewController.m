//
//  TYCorrectViewController.m
//  XFComposition
//
//  Created by wbb on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "TYCorrectViewController.h"

@interface TYCorrectViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@end

@implementation TYCorrectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView.contentSize = CGSizeMake(WidthFrame*3/2, HeightFrame);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = scrollView.contentOffset.x/kScreenWidth;
    if (index == 1) {
        [_scrollView setContentOffset:CGPointMake(index*kScreenWidth, _scrollView.contentOffset.y)];
    }
}

@end
