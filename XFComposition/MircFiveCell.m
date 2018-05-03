//
//  MircFiveCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MircFiveCell.h"
#import "MicTableViewCell.h"
#import "DianPingModel.h"
@interface MircFiveCell ()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation MircFiveCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.tableView.layer.cornerRadius = 6;
        self.tableView.layer.masksToBounds = YES;
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, WidthFrame-30, 70)];
        self.tableView.layer.borderWidth =1;
        self.tableView.layer.borderColor = [UIColorFromRGBA(135, 206, 235, 1.0f)CGColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[MicTableViewCell class] forCellReuseIdentifier:@"Miccell"];
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
    MicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Miccell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DianPingModel *model = self.array[indexPath.row];
    
    cell.gradeLabel.text = [NSString stringWithFormat:@"【%@】",model.grade];
    cell.nameLabel.text = [NSString stringWithFormat:@"作文 《%@》",model.title];
    
    cell.userLael.text = [NSString stringWithFormat:@"作者：%@",model.username];
    cell.timeLabel.text = [NSString stringWithFormat:@"点评时间:%@",model.checktime];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(gotoMircFiveCell:)]) {
        [self.delegate gotoMircFiveCell:indexPath];
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;

}
-(void)setArray:(NSArray *)array{
    _array = array;
}
@end
