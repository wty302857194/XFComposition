//
//  MyWritingDetailViewController.m
//  XFComposition
//
//  Created by chenshunyi on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "MyWritingDetailViewController.h"
#import "MyWritingDetailCell.h"

@interface MyWritingDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *heightDic;

@end

@implementation MyWritingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id cellData = [self.dataArr objectAtIndex:indexPath.row];
    CGFloat height = [[self.heightDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]] floatValue];
    if (height <= 0) {
        height = [MyWritingDetailCell cellHeight:cellData];
        [self.heightDic setObject:[NSString stringWithFormat:@"%.f",height] forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }
    
    return height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyWritingDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyWritingDetailCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MyWritingDetailCell" owner:nil options:nil].firstObject;
    }
    id cellData = [self.dataArr objectAtIndex:indexPath.row];
    [cell reloadCellData:cellData];
    return cell;
}


-(NSMutableDictionary *)heightDic{
    if (!_heightDic) {
        _heightDic = [NSMutableDictionary dictionary];
    }
    return _heightDic;
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
