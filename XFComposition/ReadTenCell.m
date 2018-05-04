//
//  ReadTenCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadTenCell.h"
#import "ReadTenTableViewCell.h"
#import "GetReadStartModel.h"
@interface ReadTenCell()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation ReadTenCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, (self.height-10)/2.f, 10, 10)];
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        label.backgroundColor = [UIColor colorWithHexString:@"ABD498"];
        [self.contentView addSubview:label];
        
        self.nameLab = [[UILabel alloc]init];
        self.nameLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label.mas_right).offset(5);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_greaterThanOrEqualTo(self.nameLab).offset(10);
        }];
        
        self.schoolLab = [[UILabel alloc]init];
        self.schoolLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.schoolLab];
        [self.schoolLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLab.mas_right).offset(5);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        self.numLab = [[UILabel alloc]init];
        self.numLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.numLab];
        
        
        [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height-1, self.width, 1)];
        imgView.image =[UIImage imageNamed:@"xuxian"];
        [self addSubview:imgView];
        
    }
    
    return self;
}
- (void)setModel:(GetReadStartModel *)model
{
    _model = model;
    self.nameLab.text = model.conname?:@"";
    self.schoolLab.text = model.readpaihangid?:@"";
    self.numLab.text = [NSString stringWithFormat:@"阅读数：%@",model.num];
}


//-(UITableView *)tableView1{
//    if (!_tableView1) {
//        _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, self.height)];
//        _tableView1.delegate = self;
//        _tableView1.dataSource = self;
//        _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_tableView1 registerClass:[ReadTenTableViewCell class] forCellReuseIdentifier:@"cell"];
//    }
//    return _tableView1;
//}
////-(UITableView *)tableView2{
////    if (!_tableView2) {
////        _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(WidthFrame/2-20, 0, WidthFrame/2-20, 80)];
////        _tableView2.delegate = self;
////        _tableView2.dataSource = self;
////        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
////        [_tableView2 registerClass:[ReadTenTableViewCell class] forCellReuseIdentifier:@"cell"];
////    }
////    return _tableView2;
////}
//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        [self.contentView addSubview:self.tableView1];
////        [self.contentView addSubview:self.tableView2];
//    }
//    return self;
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    if (tableView == self.tableView1) {
//        return self.array1.count;
//    }
//    return 0;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//        ReadTenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        GetReadStartModel *model = self.array1[indexPath.row];
//        cell.label1.text = model.conname;
//        cell.label2.text = model.readpaihangid;
//        cell.label3.text = [NSString stringWithFormat:@"阅读数：%@",model.num];
//        return cell;
//
//
//    return nil;
//
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 20;
//}
////-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
////    if (tableView == self.tableView1) {
////        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-30, 30)];
////        view.backgroundColor = [UIColor lightGrayColor];
////        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-30, 30)];
////        label.text = @"阅读情况播报";
////        label.textColor = [UIColor blueColor];
////        label.font = [UIFont systemFontOfSize:15];
////        label.textAlignment = NSTextAlignmentCenter;
////        [view addSubview:label];
////        return view;
////    }else if (tableView == self.tableView2){
////        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-30, 30)];
////        view.backgroundColor = [UIColor lightGrayColor];
////        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-30, 30)];
////        label.text = @"教师阅读";
////        label.textColor = [UIColor blueColor];
////        label.font = [UIFont systemFontOfSize:15];
////        label.textAlignment = NSTextAlignmentCenter;
////        [view addSubview:label];
////        return view;
////    }
////    return nil;
////}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.01;
//}

@end
