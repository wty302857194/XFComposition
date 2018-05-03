//
//  CompositMenuView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "CompositMenuView.h"
#import "CompositMenuCell.h"
#import "GetLabelTypeTreelistAllRequst.h"
#import "GetLabelTypeTreelistAllModel.h"
#import "GetLabelTypeTreelistSecondModel.h"
@interface CompositMenuView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *leftTableView;
@property (nonatomic,weak) UITableView *rightTableView;
@property (nonatomic,strong)NSMutableArray *array1;
@property (nonatomic,strong)NSMutableArray *array2;
@property (nonatomic,strong)NSMutableArray *Allsecondarray;
@property (nonatomic,strong)NSMutableArray *array3;
@end
@implementation CompositMenuView
-(NSMutableArray *)array1{
    if (!_array1) {
        _array1 = [NSMutableArray array];
    }
    return _array1;
}
-(NSMutableArray *)Allsecondarray{
    if (!_Allsecondarray) {
        _Allsecondarray = [NSMutableArray array];
    }
    return _Allsecondarray;
}
-(NSMutableArray *)array2{
    if (!_array2) {
        _array2 = [NSMutableArray array];
    }
    return _array2;
}
-(NSMutableArray *)array3{
    if (!_array3) {
        _array3 = [NSMutableArray array];
    }
    return _array3;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"E8F2FA"];
        UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, 90, self.frame.size.height) style:UITableViewStylePlain];
        leftTableView.tag = 1;
        leftTableView.dataSource = self;
        leftTableView.delegate = self;
        
        self.leftTableView = leftTableView;
        [leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Leftcell"];
        [self addSubview:leftTableView];
        
        UITableView *rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(100, 0, [UIScreen mainScreen].bounds.size.width-95, self.frame.size.height) style:UITableViewStylePlain];
        rightTableView.tag = 2;
        rightTableView.dataSource = self;
        rightTableView.delegate = self;
        self.rightTableView = rightTableView;
        rightTableView.showsVerticalScrollIndicator = NO;
        [rightTableView registerClass:[CompositMenuCell class] forCellReuseIdentifier:@"Rightcell"];
        [self addSubview:rightTableView];
        [self GetLabelTypeTreelistAll];
    }
    return self;
}
-(void)GetLabelTypeTreelistAll{
    GetLabelTypeTreelistAllRequst *requst = [[GetLabelTypeTreelistAllRequst alloc]init];
    [requst GetLabelTypeTreelistAllRequstwithID:@"0" withFlag:@"0" withmodelid:@"1" :^(NSDictionary *json) {
        [self.array1 removeAllObjects];
        [self.Allsecondarray removeAllObjects];
        
        for (NSDictionary *dic in json[@"ret_data"]) {
            GetLabelTypeTreelistAllModel *model1 = [GetLabelTypeTreelistAllModel loadWithJSOn:dic];
            [self.array1 addObject:model1];
            
            [self.array2 removeAllObjects];
            for (NSDictionary *dic2 in model1.childfirst) {
                GetLabelTypeTreelistSecondModel *model2 = [GetLabelTypeTreelistSecondModel loadWithJSOn:dic2];
                [self.array2 addObject:model2]; //array2 当做row
            }
            
            [self.Allsecondarray addObject:self.array2];//第2层 可以当做section
            NSLog(@"--r%lu",(unsigned long)self.array2.count);
            
        }
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
    }];
    
}
#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"--T%lu",(unsigned long)self.Allsecondarray.count);
    return tableView.tag==1 ? 1 :self.Allsecondarray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"--T%lu",(unsigned long)[self.Allsecondarray[section] count]);
    return tableView.tag==1 ? self.array1.count : [self.Allsecondarray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Leftcell" forIndexPath:indexPath];

        GetLabelTypeTreelistAllModel *model1 = self.array1[indexPath.row];
        cell.textLabel.text = model1.name;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
        
    }else{
        CompositMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Rightcell" forIndexPath:indexPath];
        
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView.tag == 1 ? 0 : 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.tag== 1 ? 44:60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2) {
//        TakeOutHeader *header = [TakeOutHeader headerWithTableView:tableView];
//        header.titleStr = self.dataArray[section][@"title"];
//        return header;
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.leftTableView.frame.size.width, 25)];
        headView.backgroundColor = [UIColor whiteColor];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WidthFrame-95, 25)];
        title.font = [UIFont systemFontOfSize:11];
        title.backgroundColor = [UIColor colorWithHexString:@"F6F7F6"];
        [headView addSubview:title];
        return headView;
    }else
        return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

@end
