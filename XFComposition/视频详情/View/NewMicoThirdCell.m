//
//  NewMicoThirdCell.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "NewMicoThirdCell.h"
@interface NewMicoThirdCell ()


@property (nonatomic, strong) NSMutableArray *selectArray;

@end


static NSString *compositionCellID = @"CompositionCell";

@implementation NewMicoThirdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CompositionCell" bundle:nil] forCellReuseIdentifier:compositionCellID];
    self.tableView.tableFooterView = [UIView new];
    
}

-(NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}
-(void)setDatas:(NSMutableArray *)datas
{
    _datas = datas;
    if (datas.count > 4) {
        self.constraint.constant = 30*datas.count;
    }
    [self.selectArray removeAllObjects];
    [self.tableView reloadData];
}

- (IBAction)clickAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 10:
            {// 新建作文
                self.clickBlock(nil, ClickTypeAdd);
            }
            break;
        case 11:
            {// 保存
                if (self.selectArray.count > 0) {
                    self.clickBlock(self.selectArray, ClickTypeSave);
                }
                
            }
            break;
        case 12:
            {// 提交教师
                if (self.selectArray.count > 0) {
                    self.clickBlock(self.selectArray, ClickTypeSubmit);
                }
            }
            break;
            
        default:
            break;
    }
}


#pragma mark - delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof (self) weakSelf = self;
    CompositionCell *cell = [tableView dequeueReusableCellWithIdentifier:compositionCellID forIndexPath:indexPath];
    MicPianduanmodel *model = self.datas[indexPath.row];
    cell.dataModel = model;
    cell.selectItemBlock = ^(BOOL isSelected) {
        
        if (isSelected) {//选中状态下，数组中没有时添加
            if (![weakSelf.selectArray containsObject:model]) {
                [weakSelf.selectArray addObject:model];
            }
        } else {//非选中状态下，数组中有时删除
            if ([weakSelf.selectArray containsObject:model]) {
                [weakSelf.selectArray removeObject:model];
            }
        }
    };
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MicPianduanmodel *model = self.datas[indexPath.row];
    self.didSelectRowBlock(model);
}

@end
