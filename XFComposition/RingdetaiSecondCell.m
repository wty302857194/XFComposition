//
//  RingdetaiSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RingdetaiSecondCell.h"
#import "RingdetailTableViewCell.h"
#import "GetMyHtListModel.h"
@interface RingdetaiSecondCell()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation RingdetaiSecondCell
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame-110)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[RingdetailTableViewCell class] forCellReuseIdentifier:@"cell"];
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
    RingdetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GetMyHtListModel *Model = self.array[indexPath.row];
    cell.model = Model;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
    GetMyHtListModel *Model = self.array[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[RingdetailTableViewCell class] contentViewWidth:WidthFrame];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(didselect:)]) {
        [self.delegate didselect:indexPath];
    }
    
}
-(void)setArray:(NSMutableArray *)array{
    _array = array;
    
    [self.tableView reloadData];
}
@end
