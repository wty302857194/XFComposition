//
//  MemberViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MemberViewController.h"
#import "MemberCell.h"
#import "GetGroupUserRequst.h"
#import "GetGroupUserModel.h"
@interface MemberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *btnArray;
@property (nonatomic,strong)NSMutableArray * memberArray;
@end

@implementation MemberViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MemberCell class] forCellReuseIdentifier:@"cell"];
//        [_tableView registerClass:[FBHuatiSecondCell class] forCellReuseIdentifier:@"cell2"];

        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
-(NSMutableArray *)memberArray{
    if (!_memberArray) {
        _memberArray = [NSMutableArray array];
    }
    return _memberArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"圈子介绍";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self GetGroupUserRequst];
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        
//        [self requstMore];
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)clickbt:(UIButton *)bt{
    for (UIButton *btn in self.btnArray) {
        if (btn.tag == bt.tag) {
            [btn setTitleColor:[UIColor colorWithHexString:@"4892E2"] forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        
    }
    
}
-(void)GetGroupUserRequst{
    GetGroupUserRequst *requst = [[GetGroupUserRequst alloc]init];
    [requst GetGroupUserRequstwithPageIndex:@"1" withPageSize:@"20" withgroupId:self.groupId :^(NSDictionary *json) {
        [self.memberArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetGroupUserModel *model = [GetGroupUserModel loadWithJSOn:dic];
            [self.memberArray addObject:model];
        }
        [self.tableView reloadData];
    }];
    
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.memberArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
//    GetGroupUserModel *Model = self.memberArray[indexPath.row];
//    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[MemberCell class] contentViewWidth:[self cellContentViewWith]];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath ];
    GetGroupUserModel *Model = self.memberArray[indexPath.row];
    cell.model = Model;
    return cell;
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 190;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 140)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 150)];
//    imgView.image = [UIImage imageNamed:@"banner_quanzi"];
    imgView.backgroundColor = [UIColor lightGrayColor];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, WidthFrame-40, 20)];
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:16];
    label1.textAlignment = NSTextAlignmentCenter;
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label1.frame)+5, WidthFrame-40, 20)];
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:15];
    label2.textAlignment = NSTextAlignmentCenter;
    UILabel *jglabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label2.frame)+5, WidthFrame-40, 2)];
    jglabel.backgroundColor = [UIColor whiteColor];
    UILabel *nrLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(jglabel.frame), WidthFrame-40, 80)];
    nrLabel.textColor = [UIColor whiteColor];
    nrLabel.font = [UIFont systemFontOfSize:13];
    [imgView addSubview:label1];
    [imgView addSubview:label2];
    [imgView addSubview:jglabel];
    [imgView addSubview:nrLabel];
    [view addSubview:imgView];
    UILabel *zzlabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame/2-1, CGRectGetMaxY(imgView.frame)+5, 2, 30)];
    zzlabel.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:zzlabel];
    label1.text = self.Model.groupName;
    label2.text = [NSString stringWithFormat:@"创始人：%@",self.Model.groupCreate];
    nrLabel.text = self.Model.groupInfo;
    NSArray *array = @[[NSString stringWithFormat:@"圈子成员(%@)",self.Model.groupUserNum],@"公告栏"];
    for (int i = 0; i<array.count; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(0+WidthFrame/2*i, CGRectGetMaxY(imgView.frame)+5, WidthFrame/2, 30);
        bt.tag = 2000+i;
        [bt setTitle:array[i] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:16];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(clickbt:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:bt];
        [self.btnArray addObject:bt];
        if (i == 0) {
            [bt setTitleColor:[UIColor colorWithHexString:@"4892E2"] forState:UIControlStateNormal];
        }
    }
    return view;
    
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
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
