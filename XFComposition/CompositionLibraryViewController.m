//
//  CompositionLibraryViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "CompositionLibraryViewController.h"
#import "LeftMenuViewController.h"
#import "CompositionLibraryTableViewCell.h"

#import "FristCollectionViewCell.h"
#import "CommWriteListRequst.h"
#import "CommwritelistModel.h"
#import "WritingxzViewController.h"

@interface CompositionLibraryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *_selectBtn;
    BOOL _isFresh;
    NSInteger _page;
    NSString *_index;
    NSString *_lableId;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)NSArray *btnArray;
@property (nonatomic,strong)NSMutableArray *compositionArray;

@property (nonatomic, strong) UIView *topBackView;
@end

@implementation CompositionLibraryViewController
-(NSArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = @[@"全部习作",@"微课习作",@"活动习作",@"独立习作"];
    }
    return _btnArray;
}
- (UIView *)topBackView
{
    if (!_topBackView) {
        _topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, kLayoutViewMarginTop, kScreenWidth, 50)];
        _topBackView.backgroundColor= [UIColor whiteColor];
        
        NSInteger btn_width = (kScreenWidth - 20 -20 -30)/4.f;
        for (int i = 0; i < self.btnArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:_btnArray[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor colorWithHexString:@"323232"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(20+(btn_width+10)*i, 10, btn_width, 30);
            btn.layer.cornerRadius = 5;
            btn.layer.masksToBounds = YES;
            btn.tag = 1000+i;
            [btn addTarget:self action:@selector(topTabBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setBackgroundColor:navigation_barColor(1)];
                _selectBtn = btn;
            }
            [_topBackView addSubview:btn];
        }
    }
    return _topBackView;
}
- (void)topTabBtnClick:(UIButton *)btn
{
    if (_selectBtn == btn) {
        return;
    }
    [btn setBackgroundColor:navigation_barColor(1)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [_selectBtn setTitleColor:[UIColor colorWithHexString:@"323232"] forState:UIControlStateNormal];
    [_selectBtn setBackgroundColor:[UIColor whiteColor]];

    
    if (btn.tag == 1000) {
        _index = @"0";
    }else if (btn.tag == 1001) {
        _index = @"5";
    }else if (btn.tag == 1002) {
        _index = @"7";
    }else if (btn.tag == 1003) {
        _index = @"4";
    }
    _page = 1;
    _isFresh = NO;
    [self requst:_index];

    _selectBtn = btn;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topBackView.height+kLayoutViewMarginTop, WidthFrame, HeightFrame-self.topBackView.height-kLayoutViewMarginTop) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
-(NSMutableArray *)compositionArray{
    if (!_compositionArray) {
        _compositionArray = [[NSMutableArray alloc]init];
    }
    return _compositionArray;
}

-(void)requst :(NSString *)gardeId{
    __weak typeof (self) weakSelf = self;
    CommWriteListRequst *requst = [[CommWriteListRequst alloc]init];
    
    [requst Comm_GetWriteListrequstWithindex:@(_page) withpagesiz:@"8" withgradid:gardeId withtypeid:@"0" withishot:@"-1" withtuijian:@"-1"  withlabelid:_lableId  withkeword:@"" BlogStatic:@"1"  :^(NSDictionary *json) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NSArray *arr = json[@"ret_data"][@"pageInfo"];
        if (_isFresh) {
            if (arr&&arr.count>0) {
                for (NSDictionary *dic in arr) {
                    CommwritelistModel *model = [CommwritelistModel loadWithJSOn:dic];
                    [weakSelf.compositionArray addObject:model];
                }
            }else {
                NSLog(@"没有更多了");
                [Global promptMessage:@"没有更多了" inView:self.view];
            }
        }else {
            [weakSelf.compositionArray removeAllObjects];
            if(arr&&arr.count>0) {
                for (NSDictionary *dic in arr) {
                    CommwritelistModel *model = [CommwritelistModel loadWithJSOn:dic];
                    [weakSelf.compositionArray addObject:model];
                }
            }else {
                [Global promptMessage:@"暂时没有数据" inView:self.view];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}
- (void)dealloc
{
    NSLog(@"dealloc-- HomeWebViewController");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"作文库";
    _page = 1;
    _index = @"0";
    _isFresh = NO;
    _lableId = @"0";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_caidan_s"] style: UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    self.navigationItem.leftBarButtonItem = item;
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.topBackView];
    [self.view addSubview:self.tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _isFresh = NO;
        _page = 1;
        [self requst:_index];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
    
    //上啦加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        _isFresh = YES;
        _page++;
        [self requst:_index];;
    }];
    
    
    // 注册手势驱动
    __weak typeof(self)weakSelf = self;
    // 第一个参数为是否开启边缘手势，开启则默认从边缘50距离内有效，第二个block为手势过程中我们希望做的操作
    [self cw_registerShowIntractiveWithEdgeGesture:NO transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        if (direction == CWDrawerTransitionFromLeft) { // 左侧滑出
            [weakSelf leftClick];
        }
    }];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRequestData:) name:@"CropOK" object:nil];
}
- (void)reloadRequestData:(NSNotification *)info {
    _lableId = info.userInfo[@"userid"];
    _page = 1;
    _isFresh = NO;
    [self requst:_index];
}
- (void)leftClick {
    
    LeftMenuViewController *vc = [[LeftMenuViewController alloc] init];
    
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromLeft backImage:[UIImage imageNamed:@"back.jpg"]];

    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeMask configuration:conf];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.compositionArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    CompositionLibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CompositionLibraryTableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CommwritelistModel *model = self.compositionArray[indexPath.row];
    cell.listModel = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WritingxzViewController *vc = [[WritingxzViewController alloc]init];
    CommwritelistModel *model = self.compositionArray[indexPath.row];
    vc.workId = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


@end
