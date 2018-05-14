//
//  TYImageEditViewController.m
//  MyPracticeViewController
//
//  Created by wbb on 2018/5/11.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "TYImageEditViewController.h"
#import "TYCorrectViewController.h"

@interface TYImageEditViewController ()
{
    CGFloat lastScale;
    CGRect oldFrame;    //保存图片原来的大小
    CGRect largeFrame;  //确定图片放大最大的程度
}
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TYImageEditViewController
- (IBAction)yuYin:(UIButton *)sender {
    switch (sender.tag) {
        case 10://语音
        {
            
        }
            break;
        case 11://截图
        {
            
        }
            break;
        case 12://旁批
        {
            [UIView animateWithDuration:0.5 animations:^{
                [self.TYCorrecVC.scrollView setContentOffset:CGPointMake(kScreenWidth/2.f, self.TYCorrecVC.scrollView.contentOffset.y)];
                self.TYCorrecVC.scrollView.scrollEnabled = YES;
            }];
        }
            break;
        case 13://手绘
        {
            
        }
            break;
        case 14://撤销
        {
            
        }
            break;
        case 15://tableview
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.imgView setMultipleTouchEnabled:YES];
    [self.imgView setUserInteractionEnabled:YES];
    oldFrame = self.imgView.frame;
    
    largeFrame = CGRectMake(-(3 * oldFrame.size.width - self.view.height)/2.f, -(3 * oldFrame.size.height - self.view.height)/2.f, 3 * oldFrame.size.width, 3 * oldFrame.size.height);
    
    [self addGestureRecognizerToView:self.imgView];
    self.view.clipsToBounds = YES;
}

//添加手势
// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}
// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
//        if (self.imgView.frame.size.width < oldFrame.size.width) {
//            self.imgView.frame = oldFrame;
//            //让图片无法缩得比原图小
//        }
//        if (self.imgView.frame.size.width > 3 * oldFrame.size.width) {
//            self.imgView.frame = largeFrame;
//        }
        pinchGestureRecognizer.scale = 1;
    }
}

@end
