//
//  MenuView.m
//  HuiBlockmenu
//
//  Created by 周凤喜 on 2017/7/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MenuView.h"
#import "MenuTableViewCell.h"



#define itemHeigth  60 //cell 高度
@interface MenuView()<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic,strong)NSMutableSet *choseSet;
@end


@implementation MenuView




-(id)initWithFrame:(CGRect)frame cellarray:(NSArray *)items block :(void(^)(NSInteger))block{
    if (self = [super initWithFrame:frame]) {

        self.itemsArray = items;
        [self.tableView reloadData];
        
        self.myblock = block;
//        [self addSubview:self.tableView];
        [self.tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        
    }
    return self;


}
-(NSMutableSet *)choseSet{
    if (!_choseSet) {
        _choseSet = [[NSMutableSet alloc]init];
    }
    return _choseSet;
}
-(UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.scrollEnabled =NO;
//    _tableView.layer.borderWidth = 2;
//    _tableView.layer.borderColor = [[UIColor colorWithHexString:@"CED3D3"] CGColor];
//    _tableView.layer.cornerRadius = 4;
//    _tableView.layer.masksToBounds=YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:_tableView];
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.label.text = self.itemsArray[indexPath.row];
    if ([self.choseSet containsObject:@(indexPath.row)]) {

        
    }else {
        cell.label.backgroundColor = [UIColor whiteColor];
        cell.label.textColor = [UIColor blackColor];
    }
    cell.label.backgroundColor = [UIColor whiteColor];
    cell.label.textColor = [UIColor blackColor];
//    cell.textLabel.text = self.itemsArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return itemHeigth;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.itemsArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.myblock) {
        self.myblock(indexPath.row);
    }
    if (![self.choseSet containsObject:@(indexPath.row)]) {
        [self.choseSet removeAllObjects];
        [self.choseSet addObject:@(indexPath.row)];
    }
    [self.tableView reloadData];
    [self dismissView];
    
    
}



-(void)showView{
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.01 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)dismissView{

    [UIView animateWithDuration:0.01 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0;
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
