//
//  LookStandarViewController.m
//  XFComposition
//
//  Created by qiannian on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "LookStandarViewController.h"
#import "LookStandarCell.h"
@interface LookStandarViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  XFTipView *tipView;

@end

@implementation LookStandarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title =@"查看标准";
    [_tableView registerNib:[UINib nibWithNibName:@"LookStandarCell" bundle:nil] forCellReuseIdentifier:@"LookStandarCell"];
    _tipView = [[NSBundle mainBundle] loadNibNamed:@"XFTipView" owner:self options:nil].lastObject;
    [_tipView setTipString:@"暂无记录"];
    if (_dataArray.count == 0) {
        _tableView.tableFooterView = _tipView;
    }else{
        _tableView.tableFooterView = nil;
    }
    [_tableView reloadData];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LookStandarCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LookStandarCell"];
    if (_dataArray.count>0) {
        [cell reloadData:_dataArray[indexPath.row]];

    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    StandardInfo * info   = _dataArray[indexPath.row];
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [SVProgressHUD showWithStatus:@"正在删除"];
        [[XFRequestManager sharedInstance] XFRequstDeleteStandard:info.StandardId  :^(NSString *requestName, id responseData, BOOL isSuccess) {
            [SVProgressHUD dismiss];
            if (isSuccess) {
                [SVProgressHUD showInfoWithStatus:@"删除成功"];
                
                [_dataArray removeObject:info];
                
                [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                
            }else{
                
                [SVProgressHUD showInfoWithStatus:@"删除失败"];
                
            }
        }] ;
        
    }];
    return @[deleteRowAction];
    
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
    // Pass the selected object to the new view controller.
}
*/

@end
