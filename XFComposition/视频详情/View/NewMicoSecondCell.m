//
//  NewMicoSecondCell.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "NewMicoSecondCell.h"
#import "CourseOutlineCell.h"

@implementation NewMicoSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CourseOutlineCell" bundle:nil] forCellReuseIdentifier:@"CourseOutlineCell"];
}

- (void)setDatas:(NSMutableArray *)datas
{
    _datas = datas;
    self.tabheightConstraint.constant = 70 *datas.count;
    [_tableView reloadData];
}

#pragma mark - delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CourseOutlineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseOutlineCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setVideoModel:self.datas[indexPath.row] atIndex:indexPath.row+1];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
