//
//  HomePaThridCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePaThridCell.h"
#import "HomePageSecondTableViewCell.h"
#import "ActiveInfoModel.h"
@interface HomePaThridCell ()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation HomePaThridCell

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame-30, 120)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HomePageSecondTableViewCell class] forCellReuseIdentifier:@"HomeSecondcell"];
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
    HomePageSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSecondcell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ActiveInfoModel *model = self.array[indexPath.row];
    cell.homeTextLabel.text = model.activename;
    
    cell.CommentLabel.text = [NSString stringWithFormat:@"%@~%@",[model.activestarttime substringToIndex:9],[model.activeendtime substringToIndex:9]];

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(gotoVolunactive:)]) {
        [self.delegate gotoVolunactive:indexPath];
    }
    
}
-(void)setArray:(NSArray *)array{
    _array = array;
    
}


@end
