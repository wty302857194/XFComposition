//
//  NewMicoSixthCell.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/9.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "NewMicoSixthCell.h"
#import "CommentViewCell.h"

@implementation NewMicoSixthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    
    [self.tabView registerNib:[UINib nibWithNibName:@"CommentViewCell" bundle:nil] forCellReuseIdentifier:@"CommentViewCell"];
}

-(void)setDatas:(NSMutableArray *)datas
{
    _datas = datas;
    self.tabHeightContraint.constant = 80 *_datas.count;
}

#pragma mark - delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.data = self.datas[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
