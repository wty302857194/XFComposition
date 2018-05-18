//
//  ApplyActiveViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ApplyActiveViewController.h"
#import "ApplyActiveFristCell.h"
#import "ApplyActiveSecondCell.h"
#import "ApplyActiveThirdCell.h"

#import "TeacherApplyVolRequst.h"

#import "JXAlertview.h"
//#import "CustomDatePicker.h"

//日期选择
#import "FDAlertView.h"
#import "RBCustomDatePickerView.h"

#import "MenuView.h"
@interface ApplyActiveViewController ()<UITableViewDelegate,UITableViewDataSource,CustomAlertDelegete,ApplyActiveThirdCellDelegate,ApplyActiveSecondCellDelegate>
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *array;
//@property (nonatomic,strong)CustomDatePicker *Dpicker;
@property (nonatomic,strong)UITextField *textfield1;
@property (nonatomic,strong)UITextField *textfield2;
@property (nonatomic,strong)UITextField *textfield3;

@property (nonatomic,strong)UIButton *bt;
@property (nonatomic,assign)NSInteger btTag;

@property (nonatomic,strong)MenuView *menuView1;
@property (nonatomic,assign)BOOL isShow1;
@property (nonatomic,strong)NSString *str1;

@property (nonatomic,strong)NSString *freeTime;
@end

@implementation ApplyActiveViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
//        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableview registerClass:[ApplyActiveFristCell class] forCellReuseIdentifier:@"cell1"];
        [_tableview registerClass:[ApplyActiveSecondCell class] forCellReuseIdentifier:@"cell2"];
        [_tableview registerClass:[ApplyActiveThirdCell class] forCellReuseIdentifier:@"cell3"];
        
    }
    return _tableview;
}
-(MenuView *)menuView1{
    if (!_menuView1) {
        __weak typeof (self) weakSelf = self;
        NSArray *array = [NSArray array];
        array = @[@"服从分配",@"本班级优先"];
        _menuView1 = [[MenuView alloc]initWithFrame:CGRectMake(105, 85+35, 100, 30*array.count)cellarray:array block:^(NSInteger i) {
            weakSelf.isShow1 = NO;

            if (i == 0) {
                [self.bt setTitle:@"服从分配" forState:UIControlStateNormal];
                weakSelf.str1 = @"0";
            }else if (i == 1){
                [self.bt setTitle:@"本班级优先" forState:UIControlStateNormal];
                weakSelf.str1 = @"1";
            }
            
        }];
        [self.tableview addSubview:_menuView1];
    }
    return _menuView1;
}
-(void)xtfenpei{
    
    
    _isShow1 = !_isShow1;
    if (_isShow1) {
        [self.menuView1 showView];
    }else{
        [self.menuView1 dismissView];
    }
    
    
    
}
-(NSMutableArray *)array{
    if (!_array) {
        _array = [[NSMutableArray alloc]init];
    }
    return _array;
}
//-(CustomDatePicker *)Dpicker{
//    if (!_Dpicker) {
//        _Dpicker = [[CustomDatePicker alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width-20, 200)];
//    }
//    return _Dpicker;
//}
-(NSString *)freeTime{
    if (!_freeTime) {
        _freeTime = [[NSString alloc]init];
    }
    return _freeTime;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"活动申请";
    self.view.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
    [self.view addSubview:self.tableview];
    
    // 添加第一个输入框对应文字内容，初始状态为空
    [self.array addObject:@""];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    
    }
    return self.array.count;
}

#pragma cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 40;
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return  100;
    }
    return 0.01;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {
        ApplyActiveFristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textfield.delegate = nil;
        self.textfield1 = [[UITextField alloc]init];
        self.textfield1 = cell.textfield;
        
        return cell;
        
    }else if (indexPath.section == 1){
        ApplyActiveSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt = cell.bt1;
        [self.bt setTitle:@"服从分配" forState:UIControlStateNormal];
        self.str1 = @"0";
        return cell;
    }else if (indexPath.section == 2){
        ApplyActiveThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        self.textfield2 = [[UITextField alloc]init];
        self.textfield3 = [[UITextField alloc]init];
        self.textfield2 = cell.textfield1;
        self.textfield3 = cell.textfield2;
        
    
//        cell.textfield1.delegate = self;
        
        return cell;
    }
    
    return nil;
}

#pragma mark - section内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 40)];
        sectionView.backgroundColor = [UIColor colorWithHexString:@"E8F2F9"];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 35)];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.text = [NSString stringWithFormat:@"您正在申请“%@”的批阅任务",self.applyTitle];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:14];
        [sectionView addSubview:titleLabel];
        
        return sectionView;
    }
    
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 40)];
//        sectionView.backgroundColor = [UIColor cyanColor];
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setTitle:@"添加" forState:UIControlStateNormal];
        [bt setBackgroundColor:[UIColor colorWithHexString:@"3691CE"]];
        bt.titleLabel.font = [UIFont systemFontOfSize:16];
        bt.layer.masksToBounds = YES;
        bt.layer.cornerRadius = 4;
        bt.frame = CGRectMake(40, 10, WidthFrame/3, 30);
        [bt addTarget:self action:@selector(addContent:event:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [sectionView addSubview:bt];
        
        UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt2 setTitle:@"删除" forState:UIControlStateNormal];
        [bt2 setBackgroundColor:[UIColor colorWithHexString:@"3691CE"]];
        bt2.frame = CGRectMake(WidthFrame/3*2 - 40, 10, WidthFrame/3, 30);
        bt2.titleLabel.font = [UIFont systemFontOfSize:16];
        bt2.layer.masksToBounds = YES;
        bt2.layer.cornerRadius = 4;
        [bt2 addTarget:self action:@selector(delContent:event:) forControlEvents:UIControlEventTouchUpInside];
        [sectionView addSubview:bt2];
        
        
        UIButton *bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt3 setTitle:@"申请成为此活动的志愿者老师" forState:UIControlStateNormal];
        [bt3 setBackgroundColor:[UIColor colorWithHexString:@"F3A832"]];
        bt3.titleLabel.font = [UIFont systemFontOfSize:16];
        bt3.layer.masksToBounds = YES;
        bt3.layer.cornerRadius = 4;
        bt3.frame = CGRectMake(WidthFrame/6 , CGRectGetMaxY(bt.frame)+10, WidthFrame/3*2, 30);
        [bt3 addTarget:self action:@selector(applyActive) forControlEvents:UIControlEventTouchUpInside];
        [sectionView addSubview:bt3];
        
        
        return sectionView;
    }
    return nil;
}

//申请成为此活动的志愿者老师
-(void)applyActive{
    XFUserInfo *xf = [XFUserInfo getUserInfo];
    self.freeTime = [NSString stringWithFormat:@"%@;%@%@", self.freeTime,self.textfield2.text, self.textfield3.text ];
//    NSLog(@"时间会给我答案%@",self.freeTime);
    TeacherApplyVolRequst *requst = [[TeacherApplyVolRequst alloc]init];
    [requst TeacherApplyVolRequstWithuserid:xf.Loginid withWriteNum:self.textfield1.text withActiveId:self.applyActiveID withfirstSet:self.str1 withjinji:@"0" withfreeTime:self.freeTime :^(NSDictionary *json) {
        if ([json[@"ret_code"] integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"申请成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:json[@"ret_data"]];
        }
//        NSLog(@"%@",json[@"ret_data"]);
    }];
//    NSLog(@"%@",self.textfield1.text);
//    NSLog(@"%@",self.textfield2.text);
//    NSLog(@"%@",self.textfield3.text);
    

}
-(void)showTextfield :(UIButton *)bt{
    self.btTag = bt.tag;
    FDAlertView *alert = [[FDAlertView alloc] init];
    RBCustomDatePickerView * contentView=[[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    contentView.delegate=self;
    alert.contentView = contentView;
    [alert show];
}
#pragma mark - JGPickerViewDelegate -
-(void)getTimeToValue:(NSString *)theTimeStr
{
    
    if (self.btTag == 1000) {
        self.textfield2.text = theTimeStr;
    }else if (self.btTag == 1001){
        self.textfield3.text = theTimeStr;
    }
    
}

//增加
- (void)addContent:(UIButton *)btn event:(id)event{
    self.freeTime = [NSString stringWithFormat:@"%@;%@%@", self.freeTime,self.textfield2.text, self.textfield3.text ];
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableview];
    NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:currentTouchPosition];
    int row = (int)indexPath.row;
    [self.array insertObject:@"" atIndex:(row + 1)];
    
    [self.tableview reloadData];

}
//删除
- (void)delContent:(UIButton *)btn event:(id)event
{
    // 多于1条记录才可以有删除操作
    if (self.array.count > 1) {
        // 获取事件发生位置，哪一条list item
        NSSet *touches = [event allTouches];
        UITouch *touch = [touches anyObject];
        CGPoint currentTouchPosition = [touch locationInView:self.tableview];
        NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:currentTouchPosition];
        int row = (int)indexPath.row;
        
        [self.array removeObjectAtIndex:row];
        
        [self.tableview reloadData];
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
