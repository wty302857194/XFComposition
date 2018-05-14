//
//  TYCorrectViewController.m
//  XFComposition
//
//  Created by wbb on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "TYCorrectViewController.h"
#import "TYImageEditViewController.h"
#import "QiPaoTagView.h"

@interface TYCorrectViewController ()<UIScrollViewDelegate>
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *rightView;
@end

@implementation TYCorrectViewController
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kLayoutViewMarginTop, kScreenWidth, kScreenHeight - kLayoutViewMarginTop - kSafeAreaMaiginBottom)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(WidthFrame*3/2, _scrollView.height);
        _scrollView.scrollEnabled = NO;
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.width, _scrollView.height)];
        [_scrollView addSubview:_leftView];
        
        TYImageEditViewController * contentViewController = [[TYImageEditViewController alloc] init];
        contentViewController.view.frame = CGRectMake(0, 0, _leftView.width, _leftView.height);
        contentViewController.TYCorrecVC = self;
        [self addChildViewController:contentViewController];
        [_leftView addSubview:contentViewController.view];
        
        
        
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(_scrollView.width, 0, _scrollView.width/2.f, _scrollView.height)];
        
        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottomBtn setTitle:@"添 加" forState:UIControlStateNormal];
        [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bottomBtn.backgroundColor = [UIColor blueColor];
        [bottomBtn addTarget:self action:@selector(addPangPi) forControlEvents:UIControlEventTouchUpInside];
        [_rightView addSubview:bottomBtn];
        [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(40);
        }];
        [_scrollView addSubview:_rightView];
    }
    return _scrollView;
}
- (void)addPangPi {
    QiPaoTagView *qiPaoView = [[QiPaoTagView alloc] initWithFrame:CGRectMake(0, 200, 160, 50)];
    qiPaoView.contentStrBlock = ^(NSString *contentStr) {
        
    };
    [_rightView addSubview:qiPaoView];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.scrollView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.x == 0) {
        scrollView.scrollEnabled = NO;
    }
}

@end
