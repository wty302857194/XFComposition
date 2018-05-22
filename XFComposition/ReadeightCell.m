//
//  ReadeightCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadeightCell.h"
#import "ReadeightTableViewCell.h"
#import "GetBookPaihangModel.h"
#import "TYTableView.h"

@interface ReadeightCell()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIImageView *backImgView;

@end
@implementation ReadeightCell
- (UIImageView *)backImgView {
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backImgView.image = [UIImage imageNamed:@"xf_book"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (_backImgView.width-10)/2, 30)];
        label.text = @"周排行";
        label.textAlignment = NSTextAlignmentCenter;
        [_backImgView addSubview:label];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake((_backImgView.width-10)/2+10, 0, (_backImgView.width-10)/2, 30)];
        label1.text = @"月排行";
        label1.textAlignment = NSTextAlignmentCenter;
        [_backImgView addSubview:label1];
        
        
    }
    return _backImgView;
}
-(UITableView *)WeekTableView{
    if (!_WeekTableView) {
        _WeekTableView = [[TYTableView alloc]initWithFrame:CGRectMake(20, 35, WidthFrame/2-50, self.height-40)];
        _WeekTableView.delegate = self;
        _WeekTableView.dataSource = self;
        [_WeekTableView registerClass:[ReadeightTableViewCell class] forCellReuseIdentifier:@"cell"];
        _WeekTableView.tableFooterView = [UIView new];
    }
    return _WeekTableView;
}
-(UITableView *)MonthTableView{
    if (!_MonthTableView) {
        _MonthTableView = [[TYTableView alloc]initWithFrame:CGRectMake(WidthFrame/2-10, 35, WidthFrame/2-50, self.height-40)];
        _MonthTableView.delegate = self;
        _MonthTableView.dataSource = self;
        [_MonthTableView registerClass:[ReadeightTableViewCell class] forCellReuseIdentifier:@"cell"];
        _MonthTableView.tableFooterView = [UIView new];

    }
    return _MonthTableView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.backImgView];
        [self.backImgView addSubview:self.WeekTableView];
        [self.backImgView addSubview:self.MonthTableView];
        
        UIImageView *topImgView = [[UIImageView alloc] init];
        topImgView.image = [UIImage imageNamed:@"xf_bookend"];
        [self.backImgView addSubview:topImgView];
        [self.backImgView bringSubviewToFront:topImgView];
        [topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_backImgView.mas_centerX);
            make.height.mas_equalTo(10);
            make.width.mas_equalTo(topImgView.mas_height).multipliedBy(36/11.f);
            make.top.mas_equalTo(50);
        }];
        
        UIImageView *topImgView1 = [[UIImageView alloc] init];
        topImgView1.image = [UIImage imageNamed:@"xf_bookend"];
        [self.backImgView addSubview:topImgView1];
        [self.backImgView bringSubviewToFront:topImgView1];
        
        [topImgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_backImgView.mas_centerX);
            make.height.mas_equalTo(10);
            make.width.mas_equalTo(topImgView.mas_height).multipliedBy(36/11.f);
            make.bottom.mas_equalTo(-50);
        }];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.WeekTableView) {
        return self.Warray.count;
    }else if (tableView == self.MonthTableView){
        return self.Marray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.WeekTableView) {
        ReadeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        GetBookPaihangModel *model = self.Warray[indexPath.row];
        if (indexPath.row <=2) {
            cell.numLabel.backgroundColor = [UIColor colorWithHexString:@"3691CE"];
        }else{
            cell.numLabel.backgroundColor = [UIColor lightGrayColor];
        }
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        
        cell.titleLabel.text = [NSString stringWithFormat:@"《%@》",model.bookname];
        return cell;
    }
    else if (tableView == self.MonthTableView){
        ReadeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row <=2) {
            cell.numLabel.backgroundColor = [UIColor colorWithHexString:@"3691CE"];
        }else{
            cell.numLabel.backgroundColor = [UIColor lightGrayColor];
        }
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        GetBookPaihangModel *model = self.Marray[indexPath.row];
        cell.titleLabel.text = [NSString stringWithFormat:@"《%@》",model.bookname];
        return cell;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 20;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (tableView == self.WeekTableView) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-40, 30)];
//        view.backgroundColor = [UIColor lightGrayColor];
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-40, 30)];
//        label.text = @"周排行";
//        label.textAlignment = NSTextAlignmentCenter;
//        [view addSubview:label];
//        return view;
//    }else if (tableView == self.MonthTableView){
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-40, 30)];
//        view.backgroundColor = [UIColor lightGrayColor];
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-40, 30)];
//        label.text = @"月排行";
//        label.textAlignment = NSTextAlignmentCenter;
//        [view addSubview:label];
//        return view;
//    }
//    return nil;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 30;
//}
-(void)setWarray:(NSMutableArray *)Warray{
    _Warray = Warray;
    if (Warray.count == 0) {
        self.WeekTableView.backgroundView.hidden = NO;
    }else {
        self.WeekTableView.backgroundView.hidden = YES;
    }
    [self.WeekTableView reloadData];
}
-(void)setMarray:(NSMutableArray *)Marray{
    _Marray = Marray;
    if (Marray.count == 0) {
        self.MonthTableView.backgroundView.hidden = NO;
    }else {
        self.MonthTableView.backgroundView.hidden = YES;
    }
    [self.MonthTableView reloadData];
}
@end
