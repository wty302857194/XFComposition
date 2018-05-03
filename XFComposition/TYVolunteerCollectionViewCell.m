//
//  TYVolunteerCollectionViewCell.m
//  XFComposition
//
//  Created by wbb on 2018/4/27.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "TYVolunteerCollectionViewCell.h"
#import "VolunteerActiveiTableViewCell.h"
#import "VolunteerNewsTableViewCell.h"
#import "VolunteerModel.h"

@interface TYVolunteerCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UIButton *_selectBtn;
    UIScrollView *_scrollView;
}
@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *rightTableView;
@property (nonatomic,strong) UIView *leftBottomView;
@property (nonatomic,strong) UIView *righBottomtView;
@end

@implementation TYVolunteerCollectionViewCell
- (UIView *)leftBottomView {
    if (!_leftBottomView) {
        _leftBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 40-30, kScreenWidth, 30)];
        _leftBottomView.backgroundColor = hexColor(f4f5f6);
        
        UIButton *btn  =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:hexColor(323232) forState:UIControlStateNormal];
        [btn setTitle:@"更多活动︾" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = 10;
        [btn addTarget:self action:@selector(moreMessage:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBottomView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_leftBottomView.mas_centerX);
            make.centerY.mas_equalTo(_leftBottomView.mas_centerY);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(30);
        }];
    }
    return _leftBottomView;
}
- (UIView *)righBottomtView {
    if (!_righBottomtView) {
        _righBottomtView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, self.height - 40-30, kScreenWidth, 30)];
        _righBottomtView.backgroundColor = hexColor(f4f5f6);
        
        UIButton *btn  =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:hexColor(323232) forState:UIControlStateNormal];
        [btn setTitle:@"更多活动︾" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = 11;
        [btn addTarget:self action:@selector(moreMessage:) forControlEvents:UIControlEventTouchUpInside];
        [_righBottomtView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_righBottomtView.mas_centerX);
            make.centerY.mas_equalTo(_righBottomtView.mas_centerY);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(30);
        }];
    }
    return _righBottomtView;
}
- (void)moreMessage:(UIButton *)btn
{
    if (self.moreMessageBlock) {
        self.moreMessageBlock(btn.tag);
    }
}
- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, self.height - 40-self.righBottomtView.height)];
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
    }
    return _rightTableView;
}
- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.height - 40 -self.leftBottomView.height)];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
    }
    return _leftTableView;
}
- (void)setActiveArr:(NSMutableArray *)activeArr {
    _activeArr = activeArr;
    
    [self.leftTableView reloadData];
}
- (void)setNewsArr:(NSMutableArray *)newsArr {
    _newsArr = newsArr;
    
    [self.rightTableView reloadData];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _tabBtnArray = [[NSMutableArray alloc]init];
        NSArray *array = @[@"志愿教师招募",@"新闻公告"];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthFrame, 40)];
        backView.backgroundColor = hexColor(f4f5f6);
        [self addSubview:backView];
        
        CGFloat btW = (WidthFrame-40)/2.f;
        for (int i = 0; i<array.count; i++) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [bt setTitle:array[i] forState:UIControlStateNormal];
            bt.backgroundColor = [UIColor whiteColor];
            bt.tag = 1000+i;
            bt.titleLabel.font = [UIFont systemFontOfSize:15];
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            bt.frame = CGRectMake(20+btW*i, 0, btW, 40);
            bt.titleLabel.adjustsFontSizeToFitWidth = YES;
            [_tabBtnArray addObject:bt];
            if (i == 0) {
                [bt setTitleColor: UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
                _selectBtn = bt;
            }
            [backView addSubview:bt];
        }
        
        self.sliderV = [[UIView alloc]initWithFrame:CGRectMake(20, 39, btW, 1)];
        self.sliderV.backgroundColor = UIColorFromRGBA(30, 144, 255, 1.0f);
        [backView addSubview:self.sliderV];
        
        
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.contentSize = CGSizeMake(kScreenWidth*2, self.height - backView.height);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backView.mas_bottom);
            make.left.bottom.right.mas_equalTo(0);
        }];
        [_scrollView addSubview:self.leftBottomView];
        [_scrollView addSubview:self.righBottomtView];

        [_scrollView addSubview:self.leftTableView];
        [_scrollView addSubview:self.rightTableView];

    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.leftTableView == tableView) {
        return 120;
    }
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.leftTableView == tableView) {
        return self.activeArr.count;
    }
    return self.newsArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        static NSString *identifier = @"identifier";
        VolunteerActiveiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"VolunteerActiveiTableViewCell" owner:nil options:nil] lastObject];
        }
        cell.model = self.activeArr[indexPath.row];
        return cell;
    }
    static NSString *identifier = @"VolunteerNews";
    VolunteerNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"VolunteerNewsTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.model = self.newsArr[indexPath.row];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = nil;
    if (tableView == self.leftTableView) {
        model = self.activeArr[indexPath.row];
    }else {
        model = self.newsArr[indexPath.row];
    }
    if (self.tableSelectBlock) {
        self.tableSelectBlock(model);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    NSInteger index  = scrollView.contentOffset.x/kScreenWidth;
    UIButton *btn = (UIButton *)self.tabBtnArray[index];
    [btn setTitleColor:UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderV.center = CGPointMake(btn.center.x, self.sliderV.center.y);
    }];
    
    [_selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor: UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
    
    _selectBtn = btn;
}
-(void)click:(UIButton *)bt{
    if (bt == _selectBtn) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [_scrollView setContentOffset:CGPointMake((bt.tag-1000)*kScreenWidth, 0)];
    }];
    if ([self.delegate respondsToSelector:@selector(VolunteerSrollView:)]) {
        [self.delegate VolunteerSrollView:bt];
    }
}

@end
