//
//  ReadeightCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadeightCell.h"
#import "ReadeightTableViewCell.h"
#import "GetBookPaihangModel.h"
@interface ReadeightCell()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation ReadeightCell
-(UITableView *)WeekTableView{
    if (!_WeekTableView) {
        _WeekTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-40, 230)];
        _WeekTableView.delegate = self;
        _WeekTableView.dataSource = self;
        [_WeekTableView registerClass:[ReadeightTableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _WeekTableView;
}
-(UITableView *)MonthTableView{
    if (!_MonthTableView) {
        _MonthTableView = [[UITableView alloc]initWithFrame:CGRectMake(WidthFrame/2, 0, WidthFrame/2-40, 230)];
        _MonthTableView.delegate = self;
        _MonthTableView.dataSource = self;
        [_MonthTableView registerClass:[ReadeightTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _MonthTableView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.WeekTableView];
        [self.contentView addSubview:self.MonthTableView];
        
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.WeekTableView) {
        return self.Warray.count;
    }else if (tableView == self.MonthTableView){
        return self.Marray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.WeekTableView) {
        ReadeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        GetBookPaihangModel *model = self.Warray[indexPath.row];
        if (indexPath.row <=2) {
            cell.numLabel.backgroundColor = [UIColor colorWithHexString:@"3691CE"];
        }else{
            cell.numLabel.backgroundColor = [UIColor lightGrayColor];
        }
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        
        cell.titleLabel.text = [NSString stringWithFormat:@"《%@》",model.bookname];
        return cell;
    }
    else if (tableView == self.MonthTableView){
        ReadeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row <=2) {
            cell.numLabel.backgroundColor = [UIColor colorWithHexString:@"3691CE"];
        }else{
            cell.numLabel.backgroundColor = [UIColor lightGrayColor];
        }
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        GetBookPaihangModel *model = self.Marray[indexPath.row];
        cell.titleLabel.text = [NSString stringWithFormat:@"《%@》",model.bookname];
        return cell;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.WeekTableView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-40, 30)];
        view.backgroundColor = [UIColor lightGrayColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-40, 30)];
        label.text = @"周排行";
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        return view;
    }else if (tableView == self.MonthTableView){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-40, 30)];
        view.backgroundColor = [UIColor lightGrayColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-40, 30)];
        label.text = @"月排行";
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(void)setWarray:(NSMutableArray *)Warray{
    _Warray = Warray;
    [self.WeekTableView reloadData];
}
-(void)setMarray:(NSMutableArray *)Marray{
    _Marray = Marray;
    [self.MonthTableView reloadData];
}
@end
