//
//  TYAllListViewController.m
//  XFComposition
//
//  Created by wbb on 2018/5/1.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "TYAllListViewController.h"
#import "VolunteerWebViewController.h"//
#import "RecruiteacherController.h"

#import "VolunteerActiveiTableViewCell.h"
#import "VolunteerNewsTableViewCell.h"
#import "TYOnlyActivetyTableViewCell.h"

#import "VolunteerModel.h"
#import "VolunteerRequst.h"


@interface TYAllListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isFresh;
    NSInteger _page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *activityArray;
@property (nonatomic,strong) NSMutableArray *newsArr;

@end

@implementation TYAllListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.activityArray = [NSMutableArray arrayWithCapacity:0];
    self.newsArr = [NSMutableArray arrayWithCapacity:0];
    _isFresh = NO;
    _page = 1;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _isFresh = NO;
        _page = 1;
        if ([self.cellString isEqualToString:@"VolunteerActiveiTableViewCell"]) {
            self.title = @"志愿者教师招募";
            [self GetReadAcitiveId:@"2"];
        }else if([self.cellString isEqualToString:@"TYOnlyActivetyTableViewCell"]){//
            self.title = @"活动";
            [self GetReadAcitiveId:@"3"];
        }else {
            self.title = @"新闻公告";
            [self getNewsListRequestData];
        }
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        _isFresh = YES;
        _page++;
        if ([self.cellString isEqualToString:@"VolunteerActiveiTableViewCell"]) {
            [self GetReadAcitiveId:@"2"];
        }else {
            [self getNewsListRequestData];
        }
    }];
    GO_BACK;
}
-(void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.cellString isEqualToString:@"VolunteerActiveiTableViewCell"]) {
        return 120;
    }
    if ([self.cellString isEqualToString:@"TYOnlyActivetyTableViewCell"]) {
         return 120;
    }
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.cellString isEqualToString:@"VolunteerActiveiTableViewCell"]||[self.cellString isEqualToString:@"TYOnlyActivetyTableViewCell"]) {
        return self.activityArray.count;
    }
    return self.newsArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";

//    Class c = NSClassFromString(self.cellString);
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:self.cellString owner:nil options:nil] lastObject];
    }
    if ([self.cellString isEqualToString:@"VolunteerActiveiTableViewCell"]) {
        VolunteerActiveiTableViewCell *ActiveiCell = cell;
        ActiveiCell.model = self.activityArray[indexPath.row];
    } else if ([self.cellString isEqualToString:@"TYOnlyActivetyTableViewCell"]) {
        TYOnlyActivetyTableViewCell *ActiveiCell = cell;
        ActiveiCell.model = self.activityArray[indexPath.row];
    }
    else {
        VolunteerNewsTableViewCell *newsCell = cell;
        newsCell.model = self.newsArr[indexPath.row];
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.cellString isEqualToString:@"VolunteerActiveiTableViewCell"]) {
        VolunteerModel *volunteerModel = self.activityArray[indexPath.row];
        RecruiteacherController *vc = [[RecruiteacherController alloc]init];
        vc.RecruitActiveID = volunteerModel.activeid;
        [self.navigationController pushViewController:vc animated:YES];
    }if ([self.cellString isEqualToString:@"TYOnlyActivetyTableViewCell"]) {
        return;
    }
    else {
        VolunteerNewsListModel *newsModel = self.newsArr[indexPath.row];
        VolunteerWebViewController *vc = [[VolunteerWebViewController alloc] init];
        vc.urlStr = [self htmlEntityDecode:newsModel.NewContent?:@""];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)GetReadAcitiveId:(NSString *)acitiveId {
    __weak typeof (self) weakSelf = self;
    VolunteerRequst *requset = [[VolunteerRequst alloc]init];
    [requset GetVolunteerRequstWithpagesize:_page :@"10" WithAcitivieTypeID:acitiveId :^(NSDictionary *josn) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        NSArray *arr = josn[@"ret_data"][@"pageInfo"];

        if (_isFresh) {
            if (arr&&arr.count>0) {
                for (NSDictionary *dic in arr) {
                    VolunteerModel *model = [VolunteerModel loadWithJSOn:dic];
                    [weakSelf.activityArray addObject:model];
                }
            }else {
                NSLog(@"没有更多了");
                [Global promptMessage:@"没有更多了" inView:self.view];
            }
        }else {
            [self.activityArray removeAllObjects];
            if(arr&&arr.count>0) {
                for (NSDictionary *dic in arr) {
                    VolunteerModel *model = [VolunteerModel loadWithJSOn:dic];
                    [weakSelf.activityArray addObject:model];
                }
            }else {
                [Global promptMessage:@"暂时没有数据" inView:self.view];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        
    }];
    
}
- (void)getNewsListRequestData
{
    
    BaseRequest *request = [BaseRequest requestWithURL:nil];
    NSDictionary *dic = @{
                          @"Action":@"GetNewsList",
                          @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                          @"PageIndex":@(_page),
                          @"PageSize":@"3"
                          };
    
    [request startWithMethod:HTTPTypePOST params:dic successedBlock:^(id succeedResult) {
        NSLog(@"ForecastUrl === %@",succeedResult);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NSArray *arr = succeedResult[@"ret_data"][@"pageInfo"];
        
        if (_isFresh) {
            if (arr&&arr.count>0) {
                for (NSDictionary *dic in arr) {
                    VolunteerNewsListModel *model = [VolunteerNewsListModel mj_objectWithKeyValues:dic];
                    [self.newsArr addObject:model];
                }
            }else {
                NSLog(@"没有更多了");
                [Global promptMessage:@"没有更多了" inView:self.view];
            }
        }else {
            [self.newsArr removeAllObjects];
            if(arr&&arr.count>0) {
                for (NSDictionary *dic in arr) {
                    VolunteerNewsListModel *model = [VolunteerNewsListModel mj_objectWithKeyValues:dic];
                    [self.newsArr addObject:model];
                }
            }else {
                [Global promptMessage:@"暂时没有数据" inView:self.view];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failedBolck:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        NSLog(@"error===%@",error.localizedDescription);
    }];
    
}
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}
@end
