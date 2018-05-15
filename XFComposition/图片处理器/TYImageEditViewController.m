//
//  TYImageEditViewController.m
//  MyPracticeViewController
//
//  Created by wbb on 2018/5/11.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "TYImageEditViewController.h"
#import "TYCorrectViewController.h"
#import "DCCommon.h"
#import "DCBezierPaintBoard.h"
//#import "DCOpenGLDrawView.h"
#import "ListSelectView.h"
#import "DCUndoBeziPathPaintBoard.h"

@interface TYImageEditViewController ()
{
    CGFloat lastScale;
    CGRect oldFrame;    //保存图片原来的大小
    CGRect largeFrame;  //确定图片放大最大的程;
    UIPinchGestureRecognizer *pinchGestureRecognizer;
    UIPanGestureRecognizer *panGestureRecognizer;
}
@property (nonatomic, assign)DCPaintColor  selectPaintColor;
@property (nonatomic, assign) BOOL isErase;
@property (nonatomic, assign) DCPaintBoardType paintBoardType;

@property (strong, nonatomic) DCBezierPaintBoard *DCUndoView;
@property (weak, nonatomic) IBOutlet UIView *topBackView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSArray *tabArr;
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
//            [UIView animateWithDuration:0.5 animations:^{
//                [self.TYCorrecVC.scrollView setContentOffset:CGPointMake(kScreenWidth/2.f, self.TYCorrecVC.scrollView.contentOffset.y)];
//                self.TYCorrecVC.scrollView.scrollEnabled = YES;
//            }];
        }
            break;
        case 13://手绘
        {
            sender.selected = !sender.selected;
            if (sender.isSelected) {
                self.DCUndoView.lineWidth = 3;
                self.DCUndoView.lineColor = [UIColor redColor];
                [self removeGestureRecognizerFromView:self.imgView];
            }else {
                self.DCUndoView.lineColor = [UIColor clearColor];
                [self addGestureRecognizerToView:self.imgView];
            }
        }
            break;
        case 14://橡皮檫
        {
            
            sender.selected = !sender.selected;
            self.isErase = sender.selected;
            if (sender.isSelected) {
                [self removeGestureRecognizerFromView:self.imgView];
            }else {
                [self addGestureRecognizerToView:self.imgView];
            }
        }
            break;
        case 15://tableview
        {
            self.tableView.hidden = !self.tableView.hidden;
        }
            break;
        default:
            break;
    }
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 80, kScreenWidth-100, (kScreenWidth-100)*2083/1602.f)];
        _imgView.backgroundColor = hexColor(ff4e00);
        [_imgView setMultipleTouchEnabled:YES];
        [_imgView setUserInteractionEnabled:YES];
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,self.PicUrl];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:str]];
        _topBackView.clipsToBounds = YES;
        [_topBackView addSubview:_imgView];

        oldFrame = _imgView.frame;
        largeFrame = CGRectMake(-(3 * oldFrame.size.width - self.view.height)/2.f, -(3 * oldFrame.size.height - self.view.height)/2.f, 3 * oldFrame.size.width, 3 * oldFrame.size.height);
        
        
        _DCUndoView = [[DCBezierPaintBoard alloc] init];
        _DCUndoView.lineColor = [UIColor clearColor];
        _DCUndoView.backgroundColor = [UIColor clearColor];
        [_imgView addSubview:_DCUndoView];
        [_DCUndoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_imgView);
        }];
    }
    return _imgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tabArr = @[@"清屏",@"颜色",@"画笔",@"还原大小",@"范文库",@"病文库",@"撤销"];
    
    [self addGestureRecognizerToView:self.imgView];
}
//取消手势
- (void)removeGestureRecognizerFromView:(UIView *)view {
    [view removeGestureRecognizer:pinchGestureRecognizer];
    [view removeGestureRecognizer:panGestureRecognizer];
}
//添加手势
// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    // 缩放手势
    pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
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
/**
 *  画笔颜色set方法
 *
 */
- (void)setSelectPaintColor:(DCPaintColor)selectPaintColor
{
    _selectPaintColor = selectPaintColor;
    switch (selectPaintColor) {
        case DCPaintColorRed:
            self.DCUndoView.lineColor = [UIColor redColor];
            break;
        case DCPaintColorBlue:
            self.DCUndoView.lineColor = [UIColor blueColor];
            break;
        case DCPaintColorGreen:
            self.DCUndoView.lineColor = [UIColor greenColor];
            break;
        case DCPaintColorBlack:
            self.DCUndoView.lineColor = [UIColor blackColor];
            break;
        default:
            self.DCUndoView.lineColor = [UIColor blackColor];
            break;
    }
}
- (void)setIsErase:(BOOL)isErase{
    _isErase = isErase;
    self.DCUndoView.isErase = isErase;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tabArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _tabArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView.hidden = YES;

    switch (indexPath.row) {
        case 0:
        {
            [self.DCUndoView clear];
        }
            break;
        case 1:
        {
            __weak typeof(self) weakSelf = self;
            ListSelectView *select_view = [[ListSelectView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height)];
            select_view.choose_type = MORECHOOSETITLETYPE;
            select_view.isShowCancelBtn = YES;
            select_view.isShowSureBtn = NO;
            select_view.isShowTitle = YES;
            select_view.title_height = 40;
            [select_view addTitleArray:@[@"红色",@"绿色",@"蓝色",@"黑色"] andTitleString:@"颜色设置" animated:YES completionHandler:^(NSString * _Nullable string, NSInteger index) {
                weakSelf.selectPaintColor = (DCPaintColor)index+1;

            } withSureButtonBlock:^{
                NSLog(@"sure btn");
            }];
            [self.navigationController.view addSubview:select_view];
        }
            break;

        case 2:
        {
            __weak typeof(self) weakSelf = self;
            ListSelectView *select_view = [[ListSelectView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height)];
            select_view.choose_type = MORECHOOSETITLETYPE;
            select_view.isShowCancelBtn = YES;
            select_view.isShowSureBtn = NO;
            select_view.isShowTitle = YES;
            select_view.title_height = 40;
            [select_view addTitleArray:@[@"细",@"中",@"粗"] andTitleString:@"画笔设置" animated:YES completionHandler:^(NSString * _Nullable string, NSInteger index) {
                NSInteger width = 0;
                switch (index) {
                    case 0:
                        width = 2;
                        break;
                    case 1:
                        width = 4;
                        break;
                    case 2:
                        width = 6;
                        break;
                    default:
                        break;
                }
                weakSelf.DCUndoView.lineWidth = width;
                
            } withSureButtonBlock:^{
                NSLog(@"sure btn");
            }];
            [self.navigationController.view addSubview:select_view];
        }
            break;
        case 3:
        {
            self.imgView.frame = oldFrame;
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            self.tableView.hidden = NO;

            [self.DCUndoView cheXiao];
        }
            break;
        default:
            break;
    }
    
}

@end
