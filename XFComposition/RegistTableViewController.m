//
//  RegistTableViewController.m
//  XFComposition
//
//  Created by wbb on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "RegistTableViewController.h"

#import "GetDeptSchoolListRequst.h"
#import "GetDeptSchoolListModel.h"

#import "ListSelectView.h"

@interface RegistTableViewController () {
    NSString *_nameStr,*_pswStr,*_isSwitch,*_isTeacher;
    NSInteger _quIndex,_schoolIndex;
}
@property (nonatomic,strong) NSMutableArray *ShiArray;
@property (nonatomic,strong) NSMutableArray *deptnameArray;
@property (nonatomic,strong) NSMutableArray *deptidArr;
@property (nonatomic,strong) NSMutableArray *schoolArr;
@property (nonatomic,strong) NSMutableArray *schoolnameArray;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIView *pswTF;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UILabel *quLab;
@property (weak, nonatomic) IBOutlet UILabel *schoolLab;
@property (weak, nonatomic) IBOutlet UIButton *studentBtn;
@property (weak, nonatomic) IBOutlet UIButton *teacherBtn;
@end

@implementation RegistTableViewController
- (IBAction)chooseQu:(UIButton *)sender {

    __weak typeof(self) weakSelf = self;
    ListSelectView *select_view = [[ListSelectView alloc] initWithFrame:CGRectMake(0, kLayoutViewMarginTop, kScreenWidth, kScreenHeight-kLayoutViewMarginTop)];
    select_view.choose_type = MORECHOOSETITLETYPE;
    select_view.isShowCancelBtn = NO;
    select_view.isShowSureBtn = NO;
    select_view.isShowTitle = NO;
    [select_view addTitleArray:self.deptnameArray andTitleString:@"温馨提示" animated:YES completionHandler:^(NSString * _Nullable string, NSInteger index) {
        _quIndex = index;
        weakSelf.quLab.text = string;
        [weakSelf getQuRequestData];
    } withSureButtonBlock:^{
        NSLog(@"sure btn");
    }];
    [self.navigationController.view addSubview:select_view];
}
- (IBAction)chooseSchool:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    ListSelectView *select_view = [[ListSelectView alloc] initWithFrame:CGRectMake(0, kLayoutViewMarginTop, kScreenWidth, kScreenHeight-kLayoutViewMarginTop)];
    select_view.choose_type = MORECHOOSETITLETYPE;
    select_view.isShowCancelBtn = NO;
    select_view.isShowSureBtn = NO;
    select_view.isShowTitle = NO;
    
    [select_view addTitleArray:self.schoolnameArray andTitleString:@"温馨提示" animated:YES completionHandler:^(NSString * _Nullable string, NSInteger index) {
        _schoolIndex = index;
        weakSelf.schoolLab.text = string;
    } withSureButtonBlock:^{
        NSLog(@"sure btn");
    }];
    [self.navigationController.view addSubview:select_view];
}
- (IBAction)teacherAndStudent:(UIButton *)sender {
    if (sender.selected == YES) {
        return;
    }
    sender.selected = !sender.selected;
    if(sender == self.studentBtn) {
        self.teacherBtn.selected = NO;
        _isTeacher = @"1";
    }else {
        self.studentBtn.selected = NO;
        _isTeacher = @"0";
    }
}
- (IBAction)nameChange:(UITextField *)sender {
    _nameStr = sender.text;
}
- (IBAction)pswChange:(UITextField *)sender {
    _pswStr = sender.text;
}
- (IBAction)switchChange:(UISwitch *)sender {
    _isSwitch = sender.on?@"on":@"off";
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
//立即注册
- (IBAction)goRegist:(UIButton *)sender {
    [self getRegistRequestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.studentBtn.selected = YES;
    self.ShiArray = [NSMutableArray arrayWithCapacity:0];
    self.deptnameArray = [NSMutableArray arrayWithCapacity:0];
    self.deptidArr = [NSMutableArray arrayWithCapacity:0];
    self.schoolArr = [NSMutableArray arrayWithCapacity:0];
    self.schoolnameArray = [NSMutableArray arrayWithCapacity:0];

    self.title = @"用户注册";
    _pswStr = @"";
    _nameStr = @"";
    _isTeacher = @"1";
    _isSwitch = @"on";
    _quIndex = 0;
    _schoolIndex = 0;
    self.tableView.tableFooterView = [UIView new];
    [self getCityRequestData];
    [self getQuRequestData];
    
    GO_BACK;
}
- (void)goBackNV {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 50;
            break;
        case 1:
            return 50;
            break;
        case 2:
            return 60;
            break;
        case 3:
            return self.mySwitch.on?50:0;
            break;
        case 4:
            return 50;
            break;
        case 5:
            return 100;
            break;
        default:
            break;
    }
    return 0;
}
/*
"Action:AddUser
Token:0A66A4FD-146F-4542-8D7B-33CDEC2981F9
regdata:{
    ""username"":""student999"",  //用户名
    ""password"":""123456"",   // 密码
    ""switch"":""on"",   //  是否为南京用户
    ""deptid"":""210100"",  //  区
    ""schoolid"":""211401"",   //  学校
    ""UserType"":""1"",  //  0老师 1学生
    ""agree"":""on""  //  是否同意注册
}    //表单数据 json格式"
*/
- (void)getRegistRequestData {
    if (_nameStr&&_nameStr.length<=0) {
        [Global promptMessage:@"请输入登录名" inView:self.navigationController.view];
        return;
    }
    if (_pswStr&&_pswStr.length<=0) {
        [Global promptMessage:@"请输入密码名" inView:self.navigationController.view];
        return;
    }
    if (_pswStr&&_pswStr.length<6) {
        [Global promptMessage:@"密码长度必须大于6位" inView:self.navigationController.view];
        return;
    }
    if(![self inputShouldLetterOrNum:_pswStr]&&_pswStr.length>0) {
        [Global promptMessage:@"密码格式不正确" inView:self.navigationController.view];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    BaseRequest *request = [BaseRequest requestWithURL:nil];
    GetDeptSchoolListModel *model  = self.schoolArr[_schoolIndex];
    NSDictionary *dic = @{
                          @"Action":@"AddUser",
                          @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                          @"regdata":@{
                                  @"username":_nameStr?:@"",
                                  @"password":_pswStr?:@"",
                                  @"switch":_isSwitch,
                                  @"deptid":self.mySwitch.on?@"":self.deptidArr[_quIndex],
                                  @"schoolid":self.mySwitch.on?@"":model.deptid?:@"",
                                  @"UserType":_isTeacher?:@"1",
                                  @"agree":@"on",
                                  }
                          };
    
    [request startWithMethod:HTTPTypePOST params:dic successedBlock:^(id succeedResult) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"ForecastUrl === %@",succeedResult);
        [Global promptMessage:succeedResult[@"ret_msg"] inView:self.navigationController.view];
    } failedBolck:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error===%@",error.localizedDescription);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
- (void)getCityRequestData {
    NSArray *arr = @[
                     @{@"deptid":@"211442",@"deptname":@"直属"},
                     @{@"deptid":@"211472",@"deptname":@"玄武区"},
                     @{@"deptid":@"211573",@"deptname":@"秦淮区"},
                     @{@"deptid":@"211721",@"deptname":@"建业区"},
                     @{@"deptid":@"211813",@"deptname":@"鼓楼区"},
                     @{@"deptid":@"211989",@"deptname":@"浦口区"},
                     @{@"deptid":@"211160",@"deptname":@"栖霞区"},
                     @{@"deptid":@"211296",@"deptname":@"雨花台区"},
                     @{@"deptid":@"211379",@"deptname":@"江宁区"},
                     @{@"deptid":@"211667",@"deptname":@"化工园区"},
                     @{@"deptid":@"211714",@"deptname":@"溧水区"},
                     @{@"deptid":@"211789",@"deptname":@"高淳县"}
                     ];
    for (NSDictionary *dic in arr) {
        GetDeptSchoolListModel *model = [GetDeptSchoolListModel loadWithJSOn:dic];
        [self.ShiArray addObject:model];
        [self.deptnameArray addObject:model.deptname];
        [self.deptidArr addObject:model.deptid];
    }
    self.quLab.text = self.deptnameArray[0];
}

- (void)getQuRequestData {
    GetDeptSchoolListRequst *requst = [[GetDeptSchoolListRequst alloc]init];
    [requst GetDeptSchoolListRequstWithblock :self.deptidArr[_quIndex] :^(NSDictionary *json) {
        [self.schoolArr removeAllObjects];
        [self.schoolnameArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            GetDeptSchoolListModel *model = [GetDeptSchoolListModel loadWithJSOn:dic];
            [self.schoolArr addObject:model];
            [self.schoolnameArray addObject:model.deptname];
        }
        GetDeptSchoolListModel *model = self.schoolArr[0];
        self.schoolLab.text = model.deptname;
    }];
}
- (BOOL)inputShouldLetterOrNum:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}

@end
