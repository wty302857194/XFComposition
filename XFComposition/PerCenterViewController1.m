//
//  PerCenterViewController1.m
//  XFComposition
//
//  Created by qiannian on 2018/5/7.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "PerCenterViewController1.h"
#import "PerCenterCell.h"
#import "MJRefresh.h"
#import "MessageDetailViewController.h"

@interface PerCenterViewController1 ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger index;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray * dataArray;
@end

@implementation PerCenterViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_tableView registerClass:[PerCenterCell class] forCellReuseIdentifier:@"PerCenterCell"];
    _dataArray = [NSMutableArray array];
    _tableView.estimatedRowHeight=450.0f;

    [self getMessagelist];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [_tableView.mj_header beginRefreshing];
    
}
-(void)getMessagelist{
    __weak typeof (self) weakSelf = self;
    
    index = 1;
    
    weakSelf.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        index = 1;
        [[XFRequestManager sharedInstance] XFRequstGetMessageList:[NSString stringWithFormat:@"%ld",(long)index] withPageSize:@"10" withtype:self.typeStr withflag:self.flagStr withuserid:[XFUserInfo getUserInfo].Loginid :^(NSString *requestName, id  responseData,BOOL isSuccess) {
            
            [weakSelf.dataArray removeAllObjects];

            weakSelf.dataArray = responseData;
            
            [weakSelf.tableView reloadData];
            
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            
        }];
    }];
    
    weakSelf.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        index ++ ;
    
        [[XFRequestManager sharedInstance] XFRequstGetMessageList:[NSString stringWithFormat:@"%ld",(long)index] withPageSize:@"10" withtype:self.typeStr withflag:self.flagStr withuserid:[XFUserInfo getUserInfo].Loginid :^(NSString *requestName, id  responseData,BOOL isSuccess){
            NSArray *array= (NSArray*)responseData;
            if (array.count == 0) {
                [SVProgressHUD showInfoWithStatus:@"没有更多数据"];
            }
            [weakSelf.dataArray addObjectsFromArray:responseData];
            
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        }];
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PerCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PerCenterCell"];
    GetMessageListModel *Model = self.dataArray[indexPath.row];
    cell.model = Model;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageDetailViewController * vc = [[MessageDetailViewController alloc]init];
    GetMessageListModel *Model = self.dataArray[indexPath.row];
    vc.msgId = Model.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 100;
    
}
#pragma mark ----------------单例--------------------
+ (instancetype)defaultPlainViewController{
    static PerCenterViewController1 *defaultPVC = nil;
    if (!defaultPVC) {
        defaultPVC = [[PerCenterViewController1 alloc] init];
    }
    return defaultPVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
 // Pa@synthesize drawer;
 
 ss the selected object to the new view controller.
}
*/

@end
