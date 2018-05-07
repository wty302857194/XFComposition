//
//  BookRankViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookRankViewController.h"
#import "BookRankTableViewCell.h"
#import "GetReadStartRequst.h"
#import "GetReadStartModel.h"
@interface BookRankViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *_selectBtn;
    UILabel *line_lab;
}
@property (nonatomic,strong)NSArray *btArray;
@property (nonatomic,strong)NSMutableArray *tabBtnArray;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *rankArray;
@property (nonatomic,strong)NSString *strFlag;
@property (nonatomic,assign)NSInteger pagesize;
@end

@implementation BookRankViewController

-(NSArray *)btArray{
    if (!_btArray) {
        _btArray = @[@"阅读之星排行",@"区排行",@"校排行",@"班级排行"];
    }
    return _btArray;
}
-(NSMutableArray *)rankArray{
    if (!_rankArray) {
        _rankArray = [[NSMutableArray alloc]init];
    }
    return _rankArray;
}
-(void)creatHeadView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, kLayoutViewMarginTop, kScreenWidth, 40)];
    topView.backgroundColor = hexColor(1d7db7);
    [self.view addSubview:topView];
    
    float btn_width = kScreenWidth/self.btArray.count;
    for (int i = 0; i<self.btArray.count; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(btn_width*i, 0, btn_width, topView.height);
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [bt setTitle:self.btArray[i] forState:UIControlStateNormal];
        bt.tag = 2000+i;
        [bt setBackgroundColor:hexColor(1d7db7)];
        [bt setTitleColor:hexColor(9ea1a2) forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:13.0];
        if (i == 0) {
            [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _selectBtn = bt;
        }
        [topView addSubview:bt];
    }
    
    line_lab = [[UILabel alloc] init];
    [line_lab setBackgroundColor:[UIColor whiteColor]];
    [topView addSubview:line_lab];
    [line_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView.mas_bottom);
        make.centerX.equalTo(_selectBtn.mas_centerX);
        make.height.mas_equalTo(1);
        make.width.equalTo(_selectBtn.mas_width);
    }];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kLayoutViewMarginTop+40, WidthFrame, HeightFrame-kLayoutViewMarginTop-40) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[BookRankTableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"读书排行";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self creatHeadView];
    self.strFlag =@"0";
    self.pagesize = 15;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self ReadStartRequst:@"0"];
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];

    GO_BACK;
}
-(void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}
//获取阅读排行
-(void)ReadStartRequst :(NSString *)flag{
    GetReadStartRequst *requst = [[GetReadStartRequst alloc]init];
    [requst GetReadStartRequstwithflag:flag withnum:@"15" :^(NSDictionary *json) {
        [self.rankArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            
            GetReadStartModel *model = [GetReadStartModel loadWithJSOn:dic];
            [self.rankArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    
}
-(void)requstMore {
    self.pagesize +=10;
    GetReadStartRequst *requst = [[GetReadStartRequst alloc]init];
    [requst GetReadStartRequstwithflag:self.strFlag withnum:[NSString stringWithFormat:@"%ld",(long)self.pagesize] :^(NSDictionary *json) {
        for (NSDictionary *dic in json[@"ret_data"]) {
            
            GetReadStartModel *model = [GetReadStartModel loadWithJSOn:dic];
            [self.rankArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];

}
-(void)click:(UIButton *)bt {
    if (bt == _selectBtn) {
        return;
    }
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_selectBtn setTitleColor:hexColor(9ea1a2) forState:UIControlStateNormal];
    
    self.pagesize = 15;
    self.strFlag = [NSString stringWithFormat:@"%lD",bt.tag-2000];
    [self ReadStartRequst:self.strFlag];
    [UIView animateWithDuration:0.1 animations:^{
        line_lab.center = CGPointMake(bt.centerX, line_lab.centerY);
    }];
    _selectBtn = bt;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.rankArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GetReadStartModel *Model = self.rankArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[BookRankTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    GetReadStartModel *Model = self.rankArray[indexPath.row];
    cell.model = Model;

    if (indexPath.row<3) {
        cell.imgView.backgroundColor = [UIColor lightGrayColor];
        cell.imgView.hidden = NO;
        cell.numLabel.hidden = YES;
    }else {
        cell.imgView.hidden = YES;
        cell.numLabel.hidden = NO;
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    }
    return cell;
    
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}



@end
