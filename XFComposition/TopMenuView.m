//
//  TopMenuView.m
//  XFComposition
//
//  Created by wbb on 2018/4/25.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "TopMenuView.h"
#import "MicroClassTypeModel.h"
#import "MicroClassGradeModel.h"

@interface TopMenuView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabHeightLayout;

@end

@implementation TopMenuView
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.backView lc_addTapGestureWithTarget:self action:@selector(removeCurrentView)];
}
- (void)removeCurrentView {
    self.hidden = YES;
}
- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    self.tabHeightLayout.constant = dataArr.count*40;
    self.tableView.scrollEnabled = NO;
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        lab.textColor = [UIColor colorWithHexString:@"323232"];
        lab.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lab];
    }

    for (UIView *view in cell.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lab = (UILabel *)view;
            if ([self.data_index isEqualToString:@"1000"]) {
                lab.text = self.dataArr[indexPath.row]?:@"";
            }else if([self.data_index isEqualToString:@"1001"]) {
                MicroClassTypeModel *model = self.dataArr[indexPath.row];
                lab.text = model.tizainame?:@"";
            }else {
                MicroClassGradeModel *model = self.dataArr[indexPath.row];
                lab.text = model.gradename?:@"";
            }
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *index_id = @"";
    NSString *data_name = @"";
    if ([self.data_index isEqualToString:@"1000"]) {
        index_id = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        data_name = self.dataArr[indexPath.row];
    }else if([self.data_index isEqualToString:@"1001"]) {
        MicroClassTypeModel *model = self.dataArr[indexPath.row];
        index_id = model.zaitiid?:@"";
        data_name = model.tizainame?:@"";
    }else {
        MicroClassGradeModel *model = self.dataArr[indexPath.row];
        index_id = model.gid?:@"";
        data_name = model.gradename?:@"";
    }
    if (self.selectTypeBlock) {
        self.selectTypeBlock(data_name,index_id,self.data_index,indexPath.row);
    }
}

@end
