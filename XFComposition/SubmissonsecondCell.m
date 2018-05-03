//
//  SubmissonsecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "SubmissonsecondCell.h"
#import "SubmissiontableViewCell.h"
#import "ActiveWriteListModel.h"

@interface SubmissonsecondCell ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation SubmissonsecondCell
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame/4*3-150)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SubmissiontableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tableView];
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
    SubmissiontableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ActiveWriteListModel *Model = self.array[indexPath.row];
    
    cell.model = Model;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100;
    ActiveWriteListModel *Model = self.array[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[SubmissiontableViewCell class] contentViewWidth:[self cellContentViewWith]];
    
}
-(void)setArray:(NSMutableArray *)array{
    _array = array;
    [self.tableView reloadData];
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
@end
