//
//  UpCompositionViewController.m
//  XFComposition
//
//  Created by wbb on 2018/4/19.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "UpCompositionViewController.h"
#import "BookwritingController.h"//BookWritingTableViewController
#import "BookWritingTableViewController.h"

#import "UpCompositionTableViewCell.h"
#import "TYOnlyActivetyTableViewCell.h"

#import "UpCompositionModel.h"
#import "VolunteerRequst.h"
#import "VolunteerModel.h"

@interface UpCompositionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD *hud;
    NSMutableArray *_zhiYuanArr;
    NSMutableArray *_activityArr;
    NSMutableArray *_weiKeArr;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSArray *titleCatgary;

@end

@implementation UpCompositionViewController
- (NSArray *)titleCatgary {
    if (!_titleCatgary) {
        _titleCatgary = @[@"独立习作",@"志愿者活动",@"活动",@"微课-正在进行"];
    }
    return _titleCatgary;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传作文";
    _zhiYuanArr = [[NSMutableArray alloc] initWithCapacity:0];
    _activityArr = [[NSMutableArray alloc] initWithCapacity:0];
    _weiKeArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    
    [self getReadActiveRequestDataForZhiYuan];
    [self getReadActiveRequestDataForActive];
    [self getReadActiveRequestDataForWeiKe];
    GO_BACK;
}
-(void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        return 0;
    }
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return _zhiYuanArr.count;
            break;
        case 2:
            return _activityArr.count;
            break;
        case 3:
            return _weiKeArr.count;
            break;
        default:
            break;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleCatgary.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    if(indexPath.section == 2) {
        TYOnlyActivetyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TYOnlyActivetyTableViewCell" owner:nil options:nil] lastObject];
        }
        VolunteerModel *model = _activityArr[indexPath.row];
        cell.model = model;
        
        return cell;
    }else {
        UpCompositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"UpCompositionTableViewCell" owner:nil options:nil] lastObject];
        }
        if (indexPath.section == 1) {
            VolunteerModel *model = _zhiYuanArr[indexPath.row];
            cell.volunteerModel = model;
            
        }else if (indexPath.section == 3) {
            UpCompositionModel *model = _weiKeArr[indexPath.row];
            model.isWeiKe = YES;
            cell.model = model;
        }
         return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 2&&_activityArr.count == 0){
        return 0;
    }
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *back_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    back_view.backgroundColor = [UIColor colorWithHexString:@"f4f5f6"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 30)];
    view.backgroundColor = [UIColor whiteColor];
    if(section == 0) {
        [view lc_addTapGestureWithTarget:self action:@selector(addActive)];
    }
    
    [back_view addSubview:view];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 5, 30-4)];
    lab.backgroundColor = navigation_barColor(1);
    [view addSubview:lab];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = self.titleCatgary[section];
    titleLab.font = [UIFont systemFontOfSize:18];
    [view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(lab.mas_right).offset(10);
    }];
    
    return back_view;
}
- (void)addActive
{
    UIStoryboard *stotyBoard = [UIStoryboard storyboardWithName:@"TYStoryboard" bundle:nil];
    BookWritingTableViewController *loginVC = [stotyBoard instantiateViewControllerWithIdentifier:@"BookWritingTableViewController"];
    loginVC.imgUrlStr = self.imgUrlStr;
    [self.navigationController pushViewController:loginVC animated:YES];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor colorWithHexString:@"f4f5f6"];
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *stotyBoard = [UIStoryboard storyboardWithName:@"TYStoryboard" bundle:nil];
    BookWritingTableViewController *loginVC = [stotyBoard instantiateViewControllerWithIdentifier:@"BookWritingTableViewController"];
    loginVC.imgUrlStr = self.imgUrlStr;
    [self.navigationController pushViewController:loginVC animated:YES];
}
#pragma mark - requestdata

- (void)getReadActiveRequestDataForZhiYuan
{
    
    __weak typeof (self) weakSelf = self;
    VolunteerRequst *requset = [[VolunteerRequst alloc]init];
    
    [requset GetVolunteerRequstWithpagesize:1 :@"2" WithAcitivieTypeID:@"0" :^(NSDictionary *josn) {
        
        NSArray *arr = josn[@"ret_data"][@"pageInfo"];
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            VolunteerModel *model = [VolunteerModel loadWithJSOn:obj];
            [_zhiYuanArr addObject:model];
            if (idx == 1) {
                *stop = YES;
            }
        }];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)getReadActiveRequestDataForActive
{
    
    [hud showAnimated:YES];
    VolunteerRequst *requset = [[VolunteerRequst alloc]init];
    [requset GetVolunteerRequstWithpagesize:1 :@"10" WithAcitivieTypeID:@"3" :^(NSDictionary *josn) {
        [hud hideAnimated:YES];
        NSArray *arr = josn[@"ret_data"][@"pageInfo"];
        
        
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            VolunteerModel *model = [VolunteerModel loadWithJSOn:obj];
            
            NSDate *currentDate = [NSDate date];
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
            NSDate *endDate = [formatter dateFromString:model.activeendtime];
            NSTimeInterval secs = [endDate timeIntervalSinceDate:currentDate];
            if(secs > 0){
                [_activityArr addObject:model];
            }
        }];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    
    
}
- (void)getReadActiveRequestDataForWeiKe
{
    //    "Action:GetMicroClassList
    //Token:0A66A4FD-146F-4542-8D7B-33CDEC2981F9
    //    changeId：3   //微课载体类别 0：全部 1：其他课程  2：同步课程 3:兴趣课程
    //    masterId：4   //微课载体  叙事 写人 写景 日志
    //    subjectId：56   //微课子类，具体到年级
    //PageIndex:1
    //PageSize:20
    //    prostatic：-1  //-1默认 0未发布 1发布
    //    recommed：-1   //-1默认 0不推荐 1推荐
    //    timeSpan：0   //0默认 1尚未开始 2正在进行 3已  经结束"
    
    [hud showAnimated:YES];
    BaseRequest *request = [BaseRequest requestWithURL:nil];
    NSDictionary *dic = @{
                          @"Action":@"GetMicroClassList",
                          @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                          @"PageIndex":@(1),
                          @"PageSize":@"9999",
                          @"changeId":@"2",
                          @"masterId":@"0",
                          @"subjectId":@"0",
                          @"prostatic":@"-1",
                          @"recommed":@"-1",
                          @"timeSpan":@"2",
                          };
    
    [request startWithMethod:HTTPTypePOST params:dic successedBlock:^(id succeedResult) {
        [hud hideAnimated:YES];
        NSLog(@"ForecastUrl === %@",succeedResult);
        NSArray *arr = succeedResult[@"ret_data"][@"pageInfo"];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UpCompositionModel *model = [UpCompositionModel mj_objectWithKeyValues:obj];
            [_weiKeArr addObject:model];
        }];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
    } failedBolck:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error===%@",error.localizedDescription);
        [hud hideAnimated:YES];
    }];
}
@end
