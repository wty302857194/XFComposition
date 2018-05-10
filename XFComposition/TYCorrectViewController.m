//
//  TYCorrectViewController.m
//  XFComposition
//
//  Created by wbb on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "TYCorrectViewController.h"

@interface TYCorrectViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scorllView;

@end

@implementation TYCorrectViewController

-(UIScrollView *)scorllView{
    if (!_scorllView) {
        _scorllView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        _scorllView.delegate = self;
        _scorllView.contentSize = CGSizeMake(WidthFrame*3/2, HeightFrame-64);
        _scorllView.pagingEnabled = YES;//设置整屏滚动
        _scorllView.bounces = YES;//设置边缘无弹跳
        //添加点按击手势监听器
//        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUiscrollView:)];
//        //设置手势属性
//        tapGesture.delegate = self;
//        tapGesture.numberOfTapsRequired=1;//设置点按次数，默认为1，注意在iOS中很少用双击操作
//        tapGesture.numberOfTouchesRequired=1;//点按的手指数
//        [_scorllView addGestureRecognizer:tapGesture];
        _scorllView.delaysContentTouches = NO;
//        UIButton *addBt = [UIButton buttonWithType:UIButtonTypeCustom];
//        [addBt setTitle:@"添加" forState:UIControlStateNormal];
//        addBt.backgroundColor = [UIColor colorWithHexString:@"348DCC"];
//        addBt.frame = CGRectMake(WidthFrame+WidthFrame/8, HeightFrame-40-64, WidthFrame/4, 30);
//        addBt.layer.cornerRadius = 4;
//        [addBt addTarget:self action:@selector(creatView) forControlEvents:UIControlEventTouchUpInside];
//        addBt.layer.masksToBounds = YES;
//        [_scorllView addSubview:addBt];
//
//        UIButton *addBt1 = [UIButton buttonWithType:UIButtonTypeCustom];
//        [addBt1 setTitle:@"编辑图片" forState:UIControlStateNormal];
//        addBt1.backgroundColor = [UIColor colorWithHexString:@"348DCC"];
//        addBt1.frame = CGRectMake(WidthFrame+WidthFrame/8, HeightFrame-40-64-40, WidthFrame/4, 30);
//        addBt1.layer.cornerRadius = 4;
//        [addBt1 addTarget:self action:@selector(creatView1) forControlEvents:UIControlEventTouchUpInside];
//        addBt1.layer.masksToBounds = YES;
//        [_scorllView addSubview:addBt1];
        
    }
    return _scorllView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
