//
//  MytestpaperViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MytestpaperViewController.h"
#import "MytestpaperCell.h"
#import "GetMyPageListRequst.h"
#import "MyPageListModel.h"
#import "DelPageInfoRequst.h"
#import "GetPageSubjectResultRequst.h"
#import "AddTestViewController.h"
#import "GetPageSubjectRequst.h"
#import "PreviewTestViewController.h"
#import "GrouplistView.h"

@interface MytestpaperViewController ()<UITableViewDelegate,UITableViewDataSource,MytestpaperCellDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *testArray;
@property (nonatomic,strong)GrouplistView *grouplistView;
@end

@implementation MytestpaperViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
        [_tableView registerClass:[MytestpaperCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
-(NSMutableArray *)testArray{
    if (!_testArray) {
        _testArray = [[NSMutableArray alloc]init];
    }
    return _testArray;
}
-(GrouplistView *)grouplistView{
    if (!_grouplistView) {
        _grouplistView = [[GrouplistView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        [self.view addSubview:self.grouplistView];
    }
    return _grouplistView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"我的试卷";
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 1;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self GetMyPageListRequst];
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
//我的试卷列表
-(void)GetMyPageListRequst{
    GetMyPageListRequst *requst = [[GetMyPageListRequst alloc]init];
    [requst GetMyPageListRequstwithPageIndex:@"1" withPageSize:@"20" withprivatpage:@"1" withuserid:self.testpaperuserId :^(NSDictionary *json) {
        [self.testArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            MyPageListModel *model = [MyPageListModel loadWithJSOn:dic];
            [self.testArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}
-(void)requstMore{
    self.page +=1;
    GetMyPageListRequst *requst = [[GetMyPageListRequst alloc]init];
    [requst GetMyPageListRequstwithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withprivatpage:@"1" withuserid:self.testpaperuserId :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            MyPageListModel *model = [MyPageListModel loadWithJSOn:dic];
            [self.testArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}
//发布到圈子
-(void)lookit:(UIButton *)bt{
    [self.grouplistView showView];
    
}
//浏览
-(void)browse:(UIButton *)bt{
    __weak typeof (self) weakSelf = self;
    MyPageListModel *Model = self.testArray[bt.tag-2000];
    GetPageSubjectRequst *requst = [[GetPageSubjectRequst alloc]init];
    [requst GetPageSubjectRequstwithpageid:[NSString stringWithFormat:@"%ld",(long)Model.ID] withuserid:self.testpaperuserId :^(NSDictionary *json) {

        PreviewTestViewController *vc = [[PreviewTestViewController alloc]init];
        vc.dic = json;
        vc.liulantype = @"1000";
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
}
//删除
-(void)delecttest:(UIButton *)bt{
//    NSLog(@"333");
    __weak typeof (self) weakSelf = self;
    MyPageListModel *Model = self.testArray[bt.tag-3000];
    DelPageInfoRequst *requst = [[DelPageInfoRequst alloc]init];
    [requst DelPageInfoRequstwithgid:[NSString stringWithFormat:@"%ld",(long)Model.ID] :^(NSDictionary *json) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:json[@"ret_msg"] message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            if ([json[@"ret_code"] isEqualToString:@"0"]){
                [weakSelf GetMyPageListRequst];
            }

        }]];

        [weakSelf presentViewController:alert animated:YES completion:nil];

    }];

}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.testArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MyPageListModel *Model = self.testArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[MytestpaperCell class] contentViewWidth:[self cellContentViewWith]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MytestpaperCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.bt1.tag = 1000+indexPath.row;
    cell.bt2.tag = 2000+indexPath.row;
    cell.bt3.tag = 3000+indexPath.row;
    MyPageListModel *Model = self.testArray[indexPath.row];
    cell.model = Model;
    return  cell;
    
    
}

#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}

-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"添加试卷" style:UIBarButtonItemStylePlain target:self action:@selector(addTest)];
    self.navigationItem.rightBarButtonItem = item2;
}
-(void)addTest{
    AddTestViewController *vc = [[AddTestViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)onBack{
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
