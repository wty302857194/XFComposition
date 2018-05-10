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
#import "PerCenterViewController1.h"
#import "PerLeftViewController.h"
#import <CoreText/CoreText.h>

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
        _tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, WidthFrame, HeightFrame) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[PersonalCell class] forCellReuseIdentifier:@"cell"];
        _tableView.tableFooterView = [UIView new];
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
        _titleArray2 = @[@"未读消息",@"我的积分",@"我的先锋币",@"完善个人信息",@"密码修改"];
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
            if (self.msg == 0) {
                cell.label2.hidden  = YES;
            }else {
                cell.label2.hidden  = NO;
                cell.label2.text = [NSString stringWithFormat:@"%ld",(long)self.msg];
            }
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
            
            PerCenterViewController1 *plainVC = [PerCenterViewController1 defaultPlainViewController];
            NSMutableAttributedString * noteStr = [[NSMutableAttributedString alloc]initWithString:@"收信箱(全部消息)"];
            NSRange range = [@"收信箱(全部消息)" rangeOfString:@"(全部消息)"];
            
            [noteStr addAttribute:(NSString *)kCTFontAttributeName
                            value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont systemFontOfSize:12].fontName,
                                                                             [UIFont systemFontOfSize:12].pointSize,
                                                                             NULL))
                            range:range];
            
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300 , 44)];
            UILabel * label = [[UILabel alloc]initWithFrame:view.frame];
            label.font = [UIFont systemFontOfSize:16];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.attributedText = noteStr;
            [view addSubview:label];
            view.frame = CGRectMake((kScreenWidth-300)/2, 20, 300, 44);
            
            //坐标系转换到titleview
            
            view.frame = [self.view.window convertRect:view.frame toView:self.navigationItem.titleView];
            plainVC.drawer.navigationItem.titleView = view;
            plainVC.flagStr = @"1";
            plainVC.typeStr = @"0";

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
            
            PerCenterViewController1 *plainVC = [PerCenterViewController1 defaultPlainViewController];
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
    GO_BACK;
}
-(void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
