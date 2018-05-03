//
//  HomeViewController.m
//  XFComposition
//
//  Created by wbb on 2018/4/17.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "HomeTableViewCell.h"
#import "AppDelegate.h"

#import "MicrodetailController.h"
#import "UpCompositionViewController.h"
#import "MicroClassViewController.h"
#import "SynchroClassViewController.h"
#import "TYAllListViewController.h"
#import "ReadAndEViewController.h"
#import "TYOnlyActivetyTableViewCell.h"

#import "HomeLessonModel.h"
#import "ActiveInfoModel.h"
#import "BookModel.h"
#import "GroupModel.h"
#import "DianPingModel.h"
#import "WriteListModel.h"

#import "UploadPicRequst.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSMutableArray *_homeLessonArr;
    BOOL _isFresh;
    NSInteger _page;
    BOOL _isClick;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}
#pragma mark - UINavigationControllerDelegate
// 将要显示控制器

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setStatusBarBackgroundColor:navigation_barColor(1)];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setStatusBarBackgroundColor:nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _homeLessonArr = [[NSMutableArray alloc] initWithCapacity:0];
    _page = 1;
    // 设置导航控制器的代理为self
//    self.navigationController.delegate = self;
    [self addTableViewHeaderView];
    
    //上啦加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        _isFresh = YES;
        _page++;
        [self ActiveRequst];
    }];
    
    [self ActiveRequst];
}
- (void)addTableViewHeaderView
{
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 420)];
    header.backgroundColor = [UIColor whiteColor];
    header.clipsToBounds = YES;
    HomeHeaderView *homeHeader = [[[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:nil options:nil] lastObject];
    [header addSubview:homeHeader];
    homeHeader.frame = header.bounds;
    self.tableView.tableHeaderView = header;
     __weak typeof(self) weakSelf = self;
    homeHeader.goPhotoBlock = ^{

        if([XFUserInfo isLogin]){
            [weakSelf openCamera];
        }else {
            [Global promptMessage:@"请先登录" inView:self.view];
            return;
        }
    };
    __weak HomeHeaderView *homeHeader_weak = homeHeader;
    
    homeHeader_weak.seeDetailBlock = ^(NSInteger tag) {
        __strong HomeHeaderView *homeHeader_strong = homeHeader_weak;
        switch (tag) {
            case 100:
            {
                AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                UITabBarController *tabbarVC = delegate.tabbarVc;
                tabbarVC.selectedIndex = 1;
                tabbarVC.selectedViewController = tabbarVC.viewControllers[1];
            }
                break;
            case 101:
            {
                MicroClassViewController *vc = [[MicroClassViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 102:
            {
                ReadAndEViewController *readVC = [[ReadAndEViewController alloc]init];
                [self.navigationController pushViewController:readVC animated:NO];
            }
                break;
            case 103:
            {
                if (!_isClick) {
                    [UIView animateWithDuration:0 animations:^{
                        homeHeader_strong.headerLayout.constant = 210;
                        header.frame = CGRectMake(0, 0, kScreenWidth, 420+105);
                    }];
                }else {
                    [UIView animateWithDuration:0 animations:^{
                        homeHeader_strong.headerLayout.constant = 210/2.f;
                        header.frame = CGRectMake(0, 0, kScreenWidth, 420);
                    }];
                }
                self.tableView.tableHeaderView = header;
                _isClick = !_isClick;
                
            }
                break;
            case 104:
            {
                AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                UITabBarController *tabbarVC = delegate.tabbarVc;
                tabbarVC.selectedIndex = 2;
                tabbarVC.selectedViewController = tabbarVC.viewControllers[2];
            }
                break;
            case 105:
            {
                TYAllListViewController *vc = [[TYAllListViewController alloc]init];
                vc.cellString = @"TYOnlyActivetyTableViewCell";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 106:
            {
                
            }
                break;
            default:
                break;
        }
    };
}
- (void)openCamera
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.delegate = self;
        pickerImage.allowsEditing = NO;
        
        
        [self presentViewController:pickerImage animated:YES completion:nil];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];

    NSData *imageData1 = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 0.2);
    UploadPicRequst *requst = [[UploadPicRequst alloc]init];

    XFUserInfo *userInfo = [XFUserInfo getUserInfo];

    [requst UploadPicRequstWithfileValue:imageData1 withuserid:userInfo.Loginid withtypeid:@"1" :^(NSDictionary *json) {

        NSLog(@"%@",json);
        if (json) {
            UpCompositionViewController *upVC = [[UpCompositionViewController alloc] init];
            upVC.imgUrlStr = json[@"ret_data"]?:@"";
            [self.navigationController pushViewController:upVC animated:YES];
        }else {
            [Global promptMessage:@"网络不好" inView:self.view];
        }
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _homeLessonArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:nil options:nil] lastObject];
        
    }
    cell.lessonModel = _homeLessonArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 5, 30-4)];
    lab.backgroundColor = navigation_barColor(1);
    [view addSubview:lab];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"正在进行的微课";
    titleLab.font = [UIFont systemFontOfSize:18];
    [view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(lab.mas_right).offset(10);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:navigation_barColor(1)];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 10;
    [btn addTarget:self action:@selector(moreMessage) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(view.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(40);
    }];
    return view;
}
- (void)moreMessage {
    SynchroClassViewController *synchroVc = [[SynchroClassViewController alloc]init];
    [self.navigationController pushViewController:synchroVc animated:NO];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WriteListModel *model = _homeLessonArr[indexPath.row];
    MicrodetailController *vc = [[MicrodetailController alloc]init];
    vc.classId = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}
/*
"Action:GetMicroClassList
Token:0A66A4FD-146F-4542-8D7B-33CDEC2981F9
changeId：3   //微课载体类别 0：全部 1：其他课程  2：同步课程 3:兴趣课程
masterId：4   //微课载体  叙事 写人 写景 日志
subjectId：56   //微课子类，具体到年级
PageIndex:1
PageSize:20
prostatic：-1  //-1默认 0未发布 1发布
recommed：-1   //-1默认 0不推荐 1推荐
timeSpan：0   //0默认 1尚未开始 2正在进行 3已  经结束"
 */
-(void)ActiveRequst{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    BaseRequest *request = [BaseRequest requestWithURL:nil];
    NSDictionary *dic = @{
                          @"Action":@"GetMicroClassList",
                          @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                          @"changeId":@"2",
                          @"masterId":@"0",
                          @"subjectId":@"0",
                          @"PageIndex":@(_page),
                          @"PageSize":@"20",
                          @"prostatic":@"-1",
                          @"recommed":@"-1",
                          @"timeSpan":@"2"
                          };
    
    [request startWithMethod:HTTPTypePOST params:dic successedBlock:^(id succeedResult) {
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"ForecastUrl === %@",succeedResult);
        NSArray *arr = succeedResult[@"ret_data"][@"pageInfo"];
        if (_isFresh) {
            if (arr&&arr.count>0) {
                for (NSDictionary *dic in arr) {
                    HomeLessonModel *lessonModel = [HomeLessonModel mj_objectWithKeyValues:dic];
                    [_homeLessonArr addObject:lessonModel];
                }
            }else {
                NSLog(@"没有更多了");
                [Global promptMessage:@"没有更多了" inView:self.view];
            }
        }else {
            [_homeLessonArr removeAllObjects];
            for (NSDictionary *dic in arr) {
                HomeLessonModel *lessonModel = [HomeLessonModel mj_objectWithKeyValues:dic];
                [_homeLessonArr addObject:lessonModel];
            }
        }
        [self.tableView reloadData];
    } failedBolck:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error===%@",error.localizedDescription);
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}


@end
