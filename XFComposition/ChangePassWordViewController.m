//
//  ChangePassWordViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "PasswordCell.h"
#import "FixPawssRequst.h"
@interface ChangePassWordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong)UITextField *textfield1;
@property (nonatomic,strong)UITextField *textfield2;
@property (nonatomic,strong)UITextField *textfield3;
@property (nonatomic,strong)XFUserInfo *xf;
@end

@implementation ChangePassWordViewController

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
        [_tableView registerClass:[PasswordCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [[NSArray alloc]init];
        _titleArray = @[@"当前密码：",@"新的密码：",@"确认密码："];
    }
    return _titleArray;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"密码修改";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

-(void)Xiugaipassword{
    
    if (![self.textfield2.text isEqualToString:self.textfield3.text]) {
        
        
        [MBProgressHUD showError:@"确认密码错误"];
        
        
        return;
    }
    FixPawssRequst *requst = [[FixPawssRequst alloc]init];
    [requst FixPawssRequstwithuserid:self.xf.Loginid witholdpwd:self.textfield1.text withnewpwd:self.textfield2.text :^(NSDictionary *json) {
        
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@",json[@"ret_msg"]]];
        
        
        
        if ([json[@"ret_code"] integerValue] == 0) {

            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    //    MBProgressHUD *HUD = [[MBProgressHUD alloc]init];
//    HUD.mode = MBProgressHUDModeIndeterminate;
//    HUD.animationType = MBProgressHUDAnimationZoomIn;
//    
//    
//    HUD.minShowTime = 10;
//    [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.label.text = self.titleArray[indexPath.row];
    [cell.label setSingleLineAutoResizeWithMaxWidth:0];
    if (indexPath.row == 0) {
        self.textfield1 = [[UITextField alloc]init];
        self.textfield1 = cell.textField;
    }else if (indexPath.row == 1){
        self.textfield2 = [[UITextField alloc]init];
        self.textfield2 = cell.textField;
    }else if (indexPath.row == 2){
        self.textfield3 = [[UITextField alloc]init];
        self.textfield3 = cell.textField;
    }
    return cell;
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 80;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 40)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, WidthFrame-40, 40)];
    label.text = @"修改你的登录密码";
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    return view;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 40)];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(WidthFrame/4, 45, WidthFrame/2, 30);
    bt.layer.cornerRadius = 4;
    bt.layer.masksToBounds = YES;
    bt.backgroundColor = [UIColor colorWithHexString:@"338CCB"];
    [bt setTitle:@"保存" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(Xiugaipassword) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bt];
    return view;
    
}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
