//
//  WeyuwenViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "WeyuwenViewController.h"
#import "WeyuwenCell.h"
#import "GetDajiaListRequst.h"
#import "GetDajiaListModel.h"
#import "YWdetailViewController.h"
@interface WeyuwenViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *yuwenArray;
@property (nonatomic,assign)NSInteger page;
@end

@implementation WeyuwenViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[WeyuwenCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
-(NSMutableArray *)yuwenArray{
    if (!_yuwenArray) {
        _yuwenArray = [NSMutableArray array];
    }
    return _yuwenArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"大家语文";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.page = 1;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self GetDajiaList];
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        
        [self requstMore];
        [self.tableView.mj_footer endRefreshing];
    }];
}
-(void)GetDajiaList{
    GetDajiaListRequst *requst = [[GetDajiaListRequst alloc]init];
    [requst GetDajiaListRequstwithClassid:@"-1" withdeptid:@"0" withNewsType:@"-1" withTags:@"76" withPageIndex:@"1" withPageSize:@"20" :^(NSDictionary *json) {
        [self.yuwenArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetDajiaListModel *model = [GetDajiaListModel loadWithJSOn:dic];
            [self.yuwenArray addObject:model];
        }
        [self.tableView reloadData];
    }];
}
-(void)requstMore{
    self.page +=1;
    GetDajiaListRequst *requst = [[GetDajiaListRequst alloc]init];
    [requst GetDajiaListRequstwithClassid:@"-1" withdeptid:@"0" withNewsType:@"-1" withTags:@"76" withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetDajiaListModel *model = [GetDajiaListModel loadWithJSOn:dic];
            [self.yuwenArray addObject:model];
        }
        [self.tableView reloadData];
    }];
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.yuwenArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    GetDajiaListModel *Model = self.yuwenArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[WeyuwenCell class] contentViewWidth:[self cellContentViewWith]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeyuwenCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GetDajiaListModel *Model = self.yuwenArray[indexPath.row];
    cell.model = Model;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GetDajiaListModel *Model = self.yuwenArray[indexPath.row];
    YWdetailViewController *vc = [[YWdetailViewController alloc]init];
    vc.model = Model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_caidan_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    
    self.navigationItem.rightBarButtonItem=item2;
    
}
-(void)onBack{
    
}
-(void)goback{
    [self.navigationController popViewControllerAnimated:YES];
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
