//
//  TakenotesViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "TakenotesViewController.h"
#import "TakenotesCell.h"
#import "GetPageListRequst.h"
#import "GetPageListModel.h"
#import "ExerciseViewController.h"
@interface TakenotesViewController ()<UITableViewDelegate,UITableViewDataSource,TakenotesCellDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *exerciseArray;
@property (nonatomic,strong)NSMutableArray *tabBtnArray;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSString *typestr;
@end

@implementation TakenotesViewController
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60+64, WidthFrame, HeightFrame-64-60) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TakenotesCell class] forCellReuseIdentifier:@"cell"];
//        [_tableView registerClass:[ReadnotesCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
-(NSMutableArray *)exerciseArray{
    if (!_exerciseArray) {
        _exerciseArray = [[NSMutableArray alloc]init];
    }
    return _exerciseArray;
}
-(void)creatHeadView{
    
    self.tabBtnArray = [[NSMutableArray alloc]init];
    NSArray *btArray = @[@"习题记录",@"试题测试"];
    for (int i = 0; i<btArray.count; i++) {
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [bt setTitle:btArray[i] forState:UIControlStateNormal];
        bt.tag = 2000+i;
        
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:18];
        bt.frame = CGRectMake(WidthFrame/2*i, 64, WidthFrame/2, 60);
        [self.view addSubview:bt];
        [self.tabBtnArray addObject:bt];
        if (i == 0) {
            [bt setTitleColor: [UIColor colorWithHexString:@"3995D1"] forState:UIControlStateNormal];
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"做题笔记";
    
    self.page = 1;
    self.typestr = @"0";
    [self creatHeadView];
    [self.view addSubview:self.tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self GetPagelist:self.typestr];
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
-(void)click:(UIButton *)bt{
    self.page = 1;
    for (UIButton *button in self.tabBtnArray){
        if (button.tag == bt.tag){
            [button setTitleColor:UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        if (bt.tag == 2000) {
            self.typestr = @"0";
            [self GetPagelist:@"0"];
        }else if (bt.tag == 2001){
            self.typestr = @"1";
            [self GetPagelist:@"1"];
            
        }
    }
}
-(void)GetPagelist :(NSString *)scheckype{
    
    GetPageListRequst *requst = [[GetPageListRequst alloc]init];
    [requst GetPageListRequstwithPageIndex:@"1" withPageSize:@"20" withchaperid:@"0" withkeyword:@"" withscheckype:scheckype withuserid:self.takenotesuserId :^(NSDictionary *json) {
        [self.exerciseArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetPageListModel *model = [GetPageListModel loadWithJSOn:dic];
            [self.exerciseArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });

    }];

}
-(void)requstMore{
    self.page +=1;
    GetPageListRequst *requst = [[GetPageListRequst alloc]init];
    [requst GetPageListRequstwithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withchaperid:@"0" withkeyword:@"" withscheckype:self.typestr withuserid:self.takenotesuserId :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetPageListModel *model = [GetPageListModel loadWithJSOn:dic];
            [self.exerciseArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    
}
-(void)chakan:(UIButton *)bt{
    
    GetPageListModel *model  = self.exerciseArray[bt.tag - 1000];
    
    ExerciseViewController *vc = [[ExerciseViewController alloc]init];
    if ([self.typestr isEqualToString:@"0"]) {
        
        vc.exerciseId = [model.TestTempID componentsSeparatedByString:@","][0];
        vc.strType = @"10";
    }else{
        vc.exerciseId = model.pageid;
        vc.strType = @"20";
    }
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
//        return 1;
//    }
    return self.exerciseArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        return 40;
//    }
    GetPageListModel *Model = self.exerciseArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[TakenotesCell class] contentViewWidth:[self cellContentViewWith]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TakenotesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    GetPageListModel *Model = self.exerciseArray[indexPath.row];
    cell.model = Model;
    cell.bt.tag = 1000 +indexPath.row;
    cell.delegate = self;
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
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
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
