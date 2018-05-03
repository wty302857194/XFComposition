//
//  MarktaskViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MarktaskViewController.h"
#import "MarktaskCell.h"
#import "GetTeachNeedActiveListRequst.h"
#import "GetTeacherNeedActiveModel.h"
#import "WorkMarkViewController.h"
@interface MarktaskViewController ()<UITableViewDelegate,UITableViewDataSource,MarktaskCellDelegate>
@property (nonatomic,strong)UITextField *textfield;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *activeArray;
@property (nonatomic,assign)NSInteger page;

@end

@implementation MarktaskViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
-(void)creatHeadView{
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(20, 5+64, WidthFrame-100, 30)];
    self.textfield.placeholder = @"输入活动名称";
    self.textfield.layer.cornerRadius = 6;
    self.textfield.layer.masksToBounds = YES;
    self.textfield.layer.borderWidth = 2;
    self.textfield.layer.borderColor = [[UIColor colorWithHexString:@"D4D5D4"] CGColor];
    self.textfield.clearButtonMode=YES;
    self.textfield.leftViewMode=UITextFieldViewModeAlways;
    [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
    self.textfield.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.textfield];
    
    UIButton *selectbt = [UIButton buttonWithType:UIButtonTypeCustom];
    selectbt.frame = CGRectMake(CGRectGetMaxX(self.textfield.frame)+10, 5+64, 50, 30);
    [selectbt setTitle:@"搜索" forState:UIControlStateNormal];
    [selectbt addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    selectbt.titleLabel.font = [UIFont systemFontOfSize:16];
    [selectbt setBackgroundColor:[UIColor colorWithHexString:@"3691CE"]];
    selectbt.layer.cornerRadius =6;
    selectbt.layer.masksToBounds = YES;
    [self.view addSubview:selectbt];

    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+45, WidthFrame, HeightFrame-64-45) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
        [_tableView registerClass:[MarktaskCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
-(NSMutableArray *)activeArray{
    if (!_activeArray) {
        _activeArray = [[NSMutableArray alloc]init];
    }
    return _activeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatHeadView];
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"批阅任务";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.page = 1;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self GetTeachNeedActiveList];
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
//获取列表
-(void)GetTeachNeedActiveList{
    __weak typeof (self) weakSelf = self;
    GetTeachNeedActiveListRequst *requst = [[GetTeachNeedActiveListRequst alloc]init];
    [requst GetTeachNeedActiveListRequstWithuserId:self.marktaskUserID withPageIndex:@"1" withPageSize:@"20" withkeyWord:self.textfield.text :^(NSDictionary *json) {
        [weakSelf.activeArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetTeacherNeedActiveModel *model = [GetTeacherNeedActiveModel loadWithJSOn:dic];
            [weakSelf.activeArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];

}

-(void)requstMore{
    self.page +=1;
    GetTeachNeedActiveListRequst *requst = [[GetTeachNeedActiveListRequst alloc]init];
    [requst GetTeachNeedActiveListRequstWithuserId:self.marktaskUserID withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withkeyWord:self.textfield.text :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetTeacherNeedActiveModel *model = [GetTeacherNeedActiveModel loadWithJSOn:dic];
            [self.activeArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];


}
//搜索
-(void)sousuo{
    [self GetTeachNeedActiveList];
    
}
//作品批阅
-(void)markTask:(UIButton *)bt{
    GetTeacherNeedActiveModel *model = self.activeArray[bt.tag-1000];
    WorkMarkViewController *vc = [[WorkMarkViewController alloc]init];
    vc.activeId = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.activeArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    GetTeacherNeedActiveModel *Model = self.activeArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[MarktaskCell class] contentViewWidth:[self cellContentViewWith]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MarktaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.bt.tag = 1000+indexPath.row;
    GetTeacherNeedActiveModel *Model = self.activeArray[indexPath.row];
    cell.model = Model;
    return  cell;
    
    
}

#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 5)];
    view.backgroundColor = [UIColor colorWithHexString:@"E8F2FA"];
    return view;

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
