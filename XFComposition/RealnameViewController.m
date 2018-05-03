//
//  RealnameViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RealnameViewController.h"
#import "RealnameFristCell.h"
#import "RealnameSecondCell.h"
#import "RealnameThridCell.h"
#import "RealnameFourCell.h"
#import "fixmyinfoRequst.h"
@interface RealnameViewController ()<UITableViewDelegate,UITableViewDataSource,RealnameThridCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)UITextField *textfield1;
@property (nonatomic,strong)UITextField *textfield2;
@property (nonatomic,strong)UITextField *textfield3;
@property (nonatomic,strong)UITextField *textfield4;
@property (nonatomic,strong)UITextField *textfield5;
@property (nonatomic,strong)NSMutableArray *btnArray;
@property (nonatomic,strong)NSString *btnState;
@end

@implementation RealnameViewController
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[RealnameFristCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[RealnameSecondCell class] forCellReuseIdentifier:@"cell2"];
        [_tableView registerClass:[RealnameThridCell class] forCellReuseIdentifier:@"cell3"];
        [_tableView registerClass:[RealnameFourCell class] forCellReuseIdentifier:@"cell4"];
    }
    return _tableView;
}
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray array];
        _titleArray = @[@"手机：",@"邮箱：",@"生日：",@"QQ："];
    }
    return _titleArray;
}
-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc]init];
    }
    return _btnArray;
}
-(NSString *)btnState{
    if (!_btnState) {
        _btnState = [[NSString alloc]init];
    }
    return _btnState;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"实名认证";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

-(void)xuanSex:(UIButton *)bt{
    for (UIButton *btn in self.btnArray) {
        if (bt.tag == btn.tag) {
            btn.backgroundColor = [UIColor redColor];
        }else{
            btn.backgroundColor = [UIColor lightGrayColor];
        }
        
    }
    if (bt.tag == 1000) {
        self.btnState = @"男";
    }else if (bt.tag == 1001){
        self.btnState = @"女";
    }else if (bt.tag == 1002){
        self.btnState = @"保密";
    }
    
}
-(void)Realname{
    fixmyinfoRequst *requst = [[fixmyinfoRequst alloc]init];
    [requst fixmyinfoRequstwithusername:self.Model.userName withusersex:self.btnState withusertype:self.Model.hjyid withuserguid:@"0" withuserphone:self.textfield2.text withuseremail:self.textfield3.text withuserbrith:self.textfield4.text withqqnum:self.textfield5.text withclassid:self.Model.u_classid withuserid:self.Model.UserDepID :^(NSDictionary *json) {
        NSLog(@"%@",json[@"ret_data"]);
        
        if ([json[@"ret_code"] isEqualToString:@"0"]){
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",json[@"ret_msg"]]];
            [self onBack];
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",json[@"ret_msg"]]];
        }
    }];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            RealnameFristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = self.Model.userId;
            [cell.titleLabel setSingleLineAutoResizeWithMaxWidth:0];
            return cell;
        }else if (indexPath.row == 1){
            RealnameSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.textfield1 = [[UITextField alloc]init];
            self.textfield1 = cell.Textfield;
            self.textfield1.text = self.Model.realName;
            
            return cell;
        }else if (indexPath.row == 2){
            RealnameThridCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.btnArray = cell.btArray;
            cell.delegate = self;
            return cell;
        }
    }else if (indexPath.section == 1){
        RealnameFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label.text = self.titleArray[indexPath.row];
        [cell.label setSingleLineAutoResizeWithMaxWidth:0];
        
        if (indexPath.row == 0) {
            self.textfield2 = [[UITextField alloc]init];
            self.textfield2 = cell.textField;
            self.textfield2.text = self.Model.sid;
        }else if (indexPath.row == 1){
            self.textfield3 = [[UITextField alloc]init];
            self.textfield3 = cell.textField;
            self.textfield3.text = self.Model.useremail;
        }else if (indexPath.row == 2){
            self.textfield4 = [[UITextField alloc]init];
            self.textfield4 = cell.textField;
            if (self.Model.birthDay.length > 1){
                    self.textfield4.text = [self.Model.birthDay substringToIndex:10];
            }else{
                    self.textfield4.text = self.Model.birthDay;
            }
        
        }else if (indexPath.row == 3){
            self.textfield5 = [[UITextField alloc]init];
            self.textfield5 = cell.textField;
            self.textfield5.text = self.Model.signatrueName;
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 40;
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 80;
    }
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 40)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, WidthFrame-40, 40)];
        label.text = @"修改你的基本资料";
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        return view;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 40)];
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(WidthFrame/4, 45, WidthFrame/2, 30);
        bt.layer.cornerRadius = 4;
        bt.layer.masksToBounds = YES;
        bt.backgroundColor = [UIColor colorWithHexString:@"338CCB"];
        [bt setTitle:@"保存" forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(Realname) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:bt];
        return view;
    }
    return nil;
}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
