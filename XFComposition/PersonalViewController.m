//
//  PersonalViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalCell.h"
#import "GetMessageWaitNumRequst.h"
#import "GetUserInfoRequst.h"
#import "PersonModel.h"

#import "ICSDrawerController.h"
#import "PerCenterViewController.h"
#import "PerLeftViewController.h"

#import "RealnameViewController.h"
#import "ChangePassWordViewController.h"
@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSArray *titleArray2;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,assign)NSInteger msg;
@property (nonatomic,strong)PersonModel *model;
@end

@implementation PersonalViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, WidthFrame, HeightFrame) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[PersonalCell class] forCellReuseIdentifier:@"cell"];
//        [_tabelView registerClass:[PerLeftSecondCell class] forCellReuseIdentifier:@"cell2"];
    }
    return _tableView;
}
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray array];
        
        _titleArray = @[@"未读消息",@"我的积分",@"我的先锋币",@"我的公益值",@"实名认证",@"密码修改"];
        
    }
    return _titleArray;
}
-(NSArray *)titleArray2{
    if (!_titleArray2) {
        _titleArray2 = [NSArray array];
        _titleArray2 = @[@"未读消息",@"我的积分",@"我的先锋币",@"实名认证",@"密码修改"];
    }
    return _titleArray2;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
-(PersonModel *)model{
    if (!_model) {
        _model = [[PersonModel alloc]init];
    }
    return _model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self GetMessageWaitNum];
        [self getInfo];
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
    
}
-(void)GetMessageWaitNum{
    GetMessageWaitNumRequst *requst = [[GetMessageWaitNumRequst alloc]init];
    [requst GetMessageWaitNumRequstWithuserid:self.xf.Loginid :^(NSDictionary *json) {
        self.msg = [json[@"ret_data"] integerValue];
        [self.tableView reloadData];
    }];
}
-(void)getInfo{
    GetUserInfoRequst *requst = [[GetUserInfoRequst alloc]init];
    [requst GetUserInfoRequstwithuserid:self.xf.Loginid :^(NSDictionary *json) {
//        self.model = [[PersonModel alloc]init];
        self.model = [PersonModel loadWithJSOn:json[@"ret_data"]];
        [self.tableView reloadData];
    }];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.model.dutyId integerValue] == 0) {
        return self.titleArray.count;
    }else{
        return self.titleArray2.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.model.dutyId integerValue] == 0) {
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            cell.label3.hidden = NO;
            cell.imgView.hidden = YES;
        }else{
            cell.imgView.hidden = NO;
            cell.label3.hidden = YES;
        }
        if (indexPath.row == 0) {
            cell.label2.hidden = NO;
        }else{
            cell.label2.hidden = YES;
        }
        cell.label1.text = self.titleArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.label2.text = [NSString stringWithFormat:@"%ld",(long)self.msg];
        }
        if (indexPath.row == 1) {
            cell.label3.text = [NSString stringWithFormat:@"%@",self.model.jifenSoft];
        }else if (indexPath.row == 2) {
            cell.label3.text = [NSString stringWithFormat:@"%ld",(long)self.model.xfbnSoft];
        }else if (indexPath.row == 3){
            cell.label3.text = [NSString stringWithFormat:@"%@",self.model.gyzSoft];
        }

    }else{
        if (indexPath.row == 1 || indexPath.row == 2 ) {
            cell.label3.hidden = NO;
            cell.imgView.hidden = YES;
        }else{
            cell.imgView.hidden = NO;
            cell.label3.hidden = YES;
        }
        if (indexPath.row == 0) {
            cell.label2.hidden = NO;
        }else{
            cell.label2.hidden = YES;
        }
        cell.label1.text = self.titleArray2[indexPath.row];
        if (indexPath.row == 0) {
            cell.label2.text = [NSString stringWithFormat:@"%ld",(long)self.msg];
        }
        if (indexPath.row == 1) {
            cell.label3.text = [NSString stringWithFormat:@"%@",self.model.jifenSoft];
        }else if (indexPath.row == 2) {
            cell.label3.text = [NSString stringWithFormat:@"%ld",(long)self.model.xfbnSoft];
        }
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.model.dutyId integerValue] == 0) {
        if (indexPath.row == 0) {
            PerLeftViewController *leftVC = [[PerLeftViewController alloc] init];
            
            PerCenterViewController *plainVC = [PerCenterViewController defaultPlainViewController];
            ICSDrawerController *drawer = [[ICSDrawerController alloc] initWithLeftViewController:leftVC centerViewController:plainVC];
            [self.navigationController pushViewController:drawer animated:YES];
        }else if (indexPath.row == 4){
            RealnameViewController *vc = [[RealnameViewController alloc]init];
            vc.Model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 5){
            ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        if (indexPath.row == 0) {
            PerLeftViewController *leftVC = [[PerLeftViewController alloc] init];
            
            PerCenterViewController *plainVC = [PerCenterViewController defaultPlainViewController];
            ICSDrawerController *drawer = [[ICSDrawerController alloc] initWithLeftViewController:leftVC centerViewController:plainVC];
            [self.navigationController pushViewController:drawer animated:YES];
        }else if (indexPath.row == 3){
            RealnameViewController *vc = [[RealnameViewController alloc]init];
            vc.Model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 4){
            ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
