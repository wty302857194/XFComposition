//
//  NewMicoThirdCell.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "NewMicoThirdCell.h"
#import "CompositionCell.h"


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

-(void)setDatas:(NSMutableArray *)datas
{
    _datas = datas;
    if (datas.count > 4) {
        self.constraint.constant = 30*datas.count;
    }
    [self.tableView reloadData];
}

- (IBAction)clickAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 10:
            {// 新建作文
                
            }
            break;
        case 11:
            {// 保存
                
            }
            break;
        case 12:
            {// 提交教师
                
            }
            break;
            
        default:
            break;
    }
}

- (void)resetFrame:(int)count
{

}

#pragma mark - delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CompositionCell *cell = [tableView dequeueReusableCellWithIdentifier:compositionCellID forIndexPath:indexPath];
    cell.dataModel = self.datas[indexPath.row];
    cell.selectItemBlock = ^(BOOL isSelected) {
        
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
}
@end
