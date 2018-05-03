//
//  MyViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MyViewController.h"
#import "MyFristTableViewCell.h"
#import "MySecondTableViewCell.h"
#import "MyThridTableViewCell.h"
#import "MyFourTableViewCell.h"
//#import "UIImageView+WebCache.h"

#import "PersonalViewController.h"
#import "MyMicroViewController.h"
#import "MyWritingsViewController.h"
#import "ReadnotesViewController.h"
#import "ApplyMarkViewController.h"
#import "TakenotesViewController.h"
#import "MyrecommendBookViewController.h"
#import "MarktaskViewController.h"
#import "MytestpaperViewController.h"
#import "MyringViewController.h"

#import "LoginRequest.h"
#import "GetUserInfoRequst.h"
#import "PersonModel.h"
@interface MyViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray *array1;
@property (nonatomic,strong)NSArray *array2;
@property (nonatomic,strong)NSArray *array3;
@property (nonatomic,strong)XFUserInfo *userInfo;
@property (nonatomic,strong)NSArray *teacherarray1;
@property (nonatomic,strong)NSArray *teacherarray2;
@property (nonatomic,strong)NSArray *teacherarray3;
@property (nonatomic,strong)PersonModel *model;
@property (nonatomic,copy)NSString *yonghuid;
//@property (nonatomic,strong)XFUserInfo *xf;
@end


@implementation MyViewController

-(NSArray *)array1{
    if (!_array1) {
        _array1 = [NSArray array];
    }
    return _array1;
}
-(NSArray *)array2{
    if (!_array2) {
        _array2 = @[@"icon_04",@"icon_05"];
    }
    return _array2;
}
-(NSArray *)array3{
    if (!_array3) {
        _array3 = @[@"icon_06",@"icon_07",@"icon_08"];
    }
    return _array3;
}
-(XFUserInfo *)userInfo{
    if (!_userInfo) {
        _userInfo = [[XFUserInfo alloc]init];
    }
    return _userInfo;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.userInfo = [XFUserInfo getUserInfo];
    _yonghuid = self.userInfo.Loginid;
    [self getInfo];
    
    
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//        
//        [self.tableView.mj_header endRefreshing];
//    }];
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
//    self.tableView.mj_header = header;
//    
//    [self.tableView.mj_header beginRefreshing];
    //接受成功消息
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(walkVCClick:) name:@"buttonLoseResponse" object:nil];
    
    //用户信息判断
    
//    if ([xf.userId isEqualToString:@"175773"] ) {
//        
//    }
    
}
//-(void)walkVCClick:(NSString *)str{
//    
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"我的";
    self.navigationController.delegate = self;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view addSubview:self.tableView];
  
    
    
 
    
  
  
   
    
    
}

-(void)Login{
    __weak typeof (self) weakSelf = self;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    LoginRequest *request = [[LoginRequest alloc]init];
    [request LoginRequstphoneText:[defaults stringForKey:@"ZhangHao"] password:[defaults stringForKey:@"MiMa"] :^(NSDictionary *dic) {
        
        weakSelf.userInfo = [XFUserInfo loadWithJSOn:dic];
//        NSLog(@"model名字 %@",model.userName);
        [XFUserInfo saveUserInfo:self.userInfo];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
    
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MyFristTableViewCell class] forCellReuseIdentifier:@"cellFrist"];
        [_tableView registerClass:[MySecondTableViewCell class] forCellReuseIdentifier:@"cellSecond"];
        [_tableView registerClass:[MyThridTableViewCell class] forCellReuseIdentifier:@"cellThrid"];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return  1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        if ([self.userInfo.dutyId isEqualToString:@"1"]) {
            return 4;
        }
        return  3;
    }else if (section == 3){
        return 2;
    }
    else if (section == 4){
        return 2;
    }
    else {
        return 1;
    }
    
}

-(void)getInfo{
       GetUserInfoRequst *requst = [[GetUserInfoRequst alloc]init];
   
        [requst GetUserInfoRequstwithuserid:_yonghuid :^(NSDictionary *json) {
            //        self.model = [[PersonModel alloc]init];
            self.model = [PersonModel loadWithJSOn:json[@"ret_data"]];
            
            [self.tableView reloadData];
        }];
 
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        MyFristTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFrist" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label.text = self.userInfo.userName;
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,self.userInfo.userFace];
        [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:str]];

        
//        NSLog(@"图片%@",self.userInfo.userName);
        return cell;
    }else if (indexPath.section == 1){
        MySecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellSecond" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
        cell.integralLabel.text = [NSString stringWithFormat:@"积分 : %@",self.model.jifenSoft];
        cell.coinLabel.text = [NSString stringWithFormat:@"先锋币 : %@ ", [NSString stringWithFormat:@"%ld",(long)self.model.xfbnSoft]];
        return  cell;
    }else if (indexPath.section == 5){
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *loginbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginbutton addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
        [loginbutton setTitle:@"退出" forState:UIControlStateNormal];
        loginbutton.frame = CGRectMake(WidthFrame/2-50, 10, 100, 30);
        loginbutton.backgroundColor = [UIColor colorWithHexString:@"348DCC"];
        loginbutton.layer.cornerRadius = 6;
        loginbutton.clipsToBounds = YES;
        [cell addSubview:loginbutton];
        
        return cell;
    }else if (indexPath.section ==2){
        
        
        if ([self.userInfo.dutyId isEqualToString:@"1"]) {
            self.teacherarray1 = @[@"个人中心",@"推荐图书",@"我的习作",@"申请批阅"];
            self.array1 = @[@"icon_01",@"icon_02",@"icon_03",@"icon_03"];
        }else if ([self.userInfo.dutyId isEqualToString:@"0"]){
            
            self.teacherarray1 = @[@"个人中心",@"推荐图书",@"批阅任务"];
            self.array1 = @[@"icon_01",@"icon_02",@"icon_03"];
        }
        
        MyThridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellThrid" forIndexPath:indexPath];
        cell.label.text = self.teacherarray1[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:self.array1[indexPath.row]];
        return cell;
    
    }else if (indexPath.section ==3){
        if ([self.userInfo.dutyId isEqualToString:@"1"]) {
            self.teacherarray2 = @[@"做题笔记",@"读书笔记"];
        }else {
            
            self.teacherarray2 = @[@"我的试卷",@"读书笔记"];
        }
        
        MyThridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellThrid" forIndexPath:indexPath];
        cell.label.text = self.teacherarray2[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:self.array2[indexPath.row]];
        return cell;
    }else if (indexPath.section ==4){
        NSArray *arry3 = @[@"我的微课",@"我的圈子"];
        MyThridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellThrid" forIndexPath:indexPath];
        cell.label.text = arry3[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:self.array3[indexPath.row]];
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }else if (indexPath.section == 1){
        return 40;
    }else if (indexPath.section == 2){
        return 45;
    }else if (indexPath.section == 3){
        return 45;
    }else if (indexPath.section == 4){
        return 45;
    }else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self.userInfo.dutyId isEqualToString:@"1"]) {
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {

                PersonalViewController *vc = [[PersonalViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row == 1) {
                MyrecommendBookViewController *vc = [[MyrecommendBookViewController alloc]init];
                vc.MyrecommenuserId = self.userInfo.Loginid;
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row == 2) {
                MyWritingsViewController *vc = [[MyWritingsViewController alloc]init];
                vc.myWritingUserid = self.userInfo.Loginid;
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row == 3){
                ApplyMarkViewController *vc = [[ApplyMarkViewController alloc]init];
                vc.applyMarkUserid = self.userInfo.Loginid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }else if (indexPath.section == 3){
            if (indexPath.row == 0) {
                TakenotesViewController *vc = [[TakenotesViewController alloc]init];
                vc.takenotesuserId = self.userInfo.Loginid;
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row == 1) {
                ReadnotesViewController *vc = [[ReadnotesViewController alloc]init];
                vc.readnotesUserid = self.userInfo.Loginid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }else if (indexPath.section == 4) {
            if (indexPath.row == 0) {
                MyMicroViewController *vc = [[MyMicroViewController alloc]init];
                vc.userID = self.userInfo.Loginid;
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row == 1){
                MyringViewController *vc = [[MyringViewController alloc]init];
                vc.Myringuserid = self.userInfo.Loginid;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        }
    }else if ([self.userInfo.dutyId isEqualToString:@"0"]){
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                
                PersonalViewController *vc = [[PersonalViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row == 1) {
                MyrecommendBookViewController *vc = [[MyrecommendBookViewController alloc]init];
                vc.MyrecommenuserId = self.userInfo.Loginid;
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row == 2) {
                MarktaskViewController *vc = [[MarktaskViewController alloc]init];
                vc.marktaskUserID = self.userInfo.Loginid;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (indexPath.section == 3){
            if (indexPath.row == 0) {
                MytestpaperViewController *vc = [[MytestpaperViewController alloc]init];
                vc.testpaperuserId = self.userInfo.Loginid;
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row == 1) {
                ReadnotesViewController *vc = [[ReadnotesViewController alloc]init];
                vc.readnotesUserid = self.userInfo.Loginid;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (indexPath.section == 4){
            if (indexPath.row == 0) {
                MyMicroViewController *vc = [[MyMicroViewController alloc]init];
                vc.userID = self.userInfo.Loginid;
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row == 1){
                MyringViewController *vc = [[MyringViewController alloc]init];
                vc.Myringuserid = self.userInfo.Loginid;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    
    }
}
-(void)logOut{
    [XFUserInfo deleteUserInfo];
    self.tabBarController.selectedIndex=0;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"ZhangHao"];
    [defaults removeObjectForKey:@"MiMa"];
    [defaults synchronize];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
