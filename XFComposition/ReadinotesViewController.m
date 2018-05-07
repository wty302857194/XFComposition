//
//  ReadinotesViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadinotesViewController.h"
#import "ReadnoteTableViewCell.h"
#import "GetBookBjRequst.h"//学生老师读书笔记
#import "GetBookBjModel.h"
#import "GetStaticBookBjRequst.h"

#import "CommentViewController.h"
@interface ReadinotesViewController ()<UITableViewDelegate,UITableViewDataSource,ReadnoteTableViewCellDelegate> {
    UIButton *_selectBtn;
    UILabel *line_lab;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *BjArray;
@property (nonatomic,strong)NSArray *btArray;
//@property (nonatomic,strong)NSMutableArray *tabBtnArray;
@property (nonatomic,assign)NSInteger staic;
@property (nonatomic,assign)NSInteger page;
@end

@implementation ReadinotesViewController

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kLayoutViewMarginTop+40, WidthFrame, HeightFrame-kLayoutViewMarginTop-40) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[ReadnoteTableViewCell class] forCellReuseIdentifier:@"cell"];

        
    }
    return _tableView;
}
-(NSMutableArray *)BjArray{
    if (!_BjArray) {
        _BjArray = [[NSMutableArray alloc]init];
    }
    return _BjArray;
}
-(NSArray *)btArray{
    if (!_btArray) {
        _btArray = @[@"学生笔记",@"教师笔记",@"在读",@"想读",@"已读"];
    }
    return _btArray;
}

//学生老师读书笔记
-(void)GetStudendAndTeacherBj :(NSString *)flag{
    GetBookBjRequst *requst = [[GetBookBjRequst alloc]init];
    [requst GetBookBjRequstWithPageIndex:@"1" withPageSize:@"20" withflag:flag withistuijian:@"0" :^(NSDictionary *json) {
        [self.BjArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetBookBjModel *model = [GetBookBjModel loadWithJSOn:dic];
            [self.BjArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
    }];
}
//获取在读想读已读笔记
-(void)GetStaicBj :(NSString *)flag{
    GetStaticBookBjRequst *requst = [[GetStaticBookBjRequst alloc]init];
    [requst GetStaticBookBjRequstWithPageIndex:@"1" withPageSize:@"20" withflag:flag withistuijian:@"0" :^(NSDictionary *json) {
        [self.BjArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetBookBjModel *model = [GetBookBjModel loadWithJSOn:dic];
            [self.BjArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });

    }];

}
-(void)requstMore :(NSString *)flag{
    self.page +=1;
    if (self.staic == 1 || self.staic ==2) {
        GetBookBjRequst *requst = [[GetBookBjRequst alloc]init];
        [requst GetBookBjRequstWithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withflag:flag withistuijian:@"0" :^(NSDictionary *json) {
            
            for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
                GetBookBjModel *model = [GetBookBjModel loadWithJSOn:dic];
                [self.BjArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }else{
        GetStaticBookBjRequst *requst = [[GetStaticBookBjRequst alloc]init];
        [requst GetStaticBookBjRequstWithPageIndex:@"1" withPageSize:@"20" withflag:flag withistuijian:@"0" :^(NSDictionary *json) {
            for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
                GetBookBjModel *model = [GetBookBjModel loadWithJSOn:dic];
                [self.BjArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        }];
    }
}
-(void)creatHeadView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, kLayoutViewMarginTop, kScreenWidth, 40)];
    topView.backgroundColor = hexColor(1d7db7);
    [self.view addSubview:topView];
    
    float btn_width = kScreenWidth/self.btArray.count;
    for (int i = 0; i<self.btArray.count; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(btn_width*i, 0, btn_width, topView.height);
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [bt setTitle:self.btArray[i] forState:UIControlStateNormal];
        bt.tag = 2000+i;
        [bt setBackgroundColor:hexColor(1d7db7)];
        [bt setTitleColor:hexColor(9ea1a2) forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:13.0];
        if (i == 0) {
            [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _selectBtn = bt;
        }
        [topView addSubview:bt];
    }
    
    line_lab = [[UILabel alloc] init];
    [line_lab setBackgroundColor:[UIColor whiteColor]];
    [topView addSubview:line_lab];
    [line_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView.mas_bottom);
        make.centerX.equalTo(_selectBtn.mas_centerX);
        make.height.mas_equalTo(1);
        make.width.equalTo(_selectBtn.mas_width);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"读书笔记";
    self.view.backgroundColor = [UIColor whiteColor];
    self.staic = 1;
    self.page = 1;
    [self creatHeadView];
    [self.view addSubview:self.tableView];
    [self GetStudendAndTeacherBj:@"1"];
    
    self.tableView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        if (self.staic == 1) {
            [self requstMore:@"1"];
        }else if(self.staic == 2) {
            [self requstMore:@"2"];
        }else if(self.staic == 3) {
            [self requstMore:@"0"];
        }else if(self.staic == 4) {
            [self requstMore:@"1"];
        }else if(self.staic == 5) {
            [self requstMore:@"2"];
        }
        [self.tableView.mj_footer endRefreshing];
    }];
    
    GO_BACK;
}
-(void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.BjArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadnoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    GetBookBjModel *Model = self.BjArray[indexPath.row];
    cell.model = Model;
    cell.bt.tag = indexPath.row+1000;
    return cell;
    
}

-(void)click:(UIButton *)bt {
    if (bt == _selectBtn) {
        return;
    }
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_selectBtn setTitleColor:hexColor(9ea1a2) forState:UIControlStateNormal];
    self.staic = bt.tag-2000+1;
    self.page= 1;
    if (bt.tag == 2000) {
        [self GetStudendAndTeacherBj:@"1"];
    }else if (bt.tag == 2001){
        [self GetStudendAndTeacherBj:@"2"];
    }else if (bt.tag == 2002){
        [self GetStaicBj:@"0"];
    }else if (bt.tag == 2003){
        [self GetStaicBj:@"1"];
    }else if (bt.tag == 2004){
        [self GetStaicBj:@"2"];
    }
    [UIView animateWithDuration:0.1 animations:^{
        line_lab.center = CGPointMake(bt.centerX, line_lab.centerY);
    }];
    _selectBtn = bt;
}
-(void)comment:(UIButton *)bt{
    GetBookBjModel *Model = self.BjArray[bt.tag -1000];
    
    CommentViewController *vc = [[CommentViewController alloc]init];
    vc.commentId = Model.bookId;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
