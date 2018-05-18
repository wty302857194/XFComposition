//
//  RecruiteacherSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RecruiteacherSecondCell.h"
#import "RecruitableviewCell.h"
#import "GetActiveApplyTeacherList.h"
#import "GetActiveApplyTeacherModel.h"
@interface RecruiteacherSecondCell()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation RecruiteacherSecondCell

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame/4*3-150)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[RecruitableviewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
-(NSMutableArray *)array{
    if (!_array) {
        _array = [[NSMutableArray alloc]init];
        
    }
    return _array;
}
//老师列表
-(void)ApplyTeacherList{
    GetActiveApplyTeacherList *requst = [[GetActiveApplyTeacherList alloc]init];
    [requst GetActiveApplyTeacherListWithPageIndex:1 withPageSize:20 withactiveid:self.activiID withteacherstatic:@"1" :^(NSDictionary *josn) {
        [self.array removeAllObjects];
        for (NSDictionary *dic in josn[@"ret_data"][@"pageInfo"]) {
            GetActiveApplyTeacherModel *model = [GetActiveApplyTeacherModel loadWithJSOn:dic];
            [self.array addObject:model];
        }
        [self.tableView reloadData];
    }];
    
    
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tableView];
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

            [self ApplyTeacherList];
            [self.tableView.mj_header endRefreshing];
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        self.tableView.mj_header = header;
        
        [self.tableView.mj_header beginRefreshing];
        
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecruitableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GetActiveApplyTeacherModel *model = self.array[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.teacherpic];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"sj"] options:SDWebImageRefreshCached];
    cell.teacherLabel.text = model.teachername;
    cell.xuexiaoLabel.text = model.teacherschool;
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
}

@end
