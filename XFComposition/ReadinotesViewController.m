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
@interface ReadinotesViewController ()<UITableViewDelegate,UITableViewDataSource,ReadnoteTableViewCellDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *BjArray;
@property (nonatomic,strong)NSArray *btArray;
@property (nonatomic,strong)NSMutableArray *tabBtnArray;
@property (nonatomic,assign)NSInteger staic;
@property (nonatomic,assign)NSInteger page;
@end

@implementation ReadinotesViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, WidthFrame, HeightFrame-64-40) style:UITableViewStyleGrouped];
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
//                NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:1];
                [self.tableView reloadData];
            });
            
        }];

    
    
    }

}
-(void)creatHeadView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame , 40)];
    [self.view addSubview:scrollView];
    self.tabBtnArray = [[NSMutableArray alloc]init];
    scrollView.showsHorizontalScrollIndicator = NO;
    CGFloat z= 0.0;
    for (int i = 0; i<self.btArray.count; i++) {
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [bt setTitle:self.btArray[i] forState:UIControlStateNormal];
        bt.tag = 2000+i;
        
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:13.0];
        CGSize titleSize = [self.btArray[i] sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:bt.titleLabel.font.fontName size:bt.titleLabel.font.pointSize]}];
        
        
        titleSize.width +=20;
        CGFloat flo = titleSize.width;
        
        
        
        bt.frame = CGRectMake(20+z, 0, titleSize.width, 40);
        z= flo +z+15;
        
        scrollView.contentSize = CGSizeMake((titleSize.width+30)*(self.btArray.count+1), 40);
        [scrollView addSubview:bt];
        [self.tabBtnArray addObject:bt];
        if (i == 0) {
            [bt setTitleColor: UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
        }
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"读书笔记";
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"3690CE"];
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

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
//        return 0;
//    }
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

-(void)click:(UIButton *)bt{
    for (UIButton *button in self.tabBtnArray){
        if (button.tag == bt.tag){
            [button setTitleColor:UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
            if (bt.tag == 2000) {
                self.staic = 1;
                self.page= 1;
                [self GetStudendAndTeacherBj:@"1"];
                
            }else if (bt.tag == 2001){
                self.staic = 2;
                self.page= 1;
                [self GetStudendAndTeacherBj:@"2"];
            }else if (bt.tag == 2002){
                self.staic = 3;
                self.page= 1;
                [self GetStaicBj:@"0"];
            }else if (bt.tag == 2003){
                self.staic = 4;
                self.page= 1;
                [self GetStaicBj:@"1"];
            }else if (bt.tag == 2004){
                self.staic = 5;
                self.page= 1;
                [self GetStaicBj:@"2"];
            }

        }else{
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        
    }
    
}
-(void)comment:(UIButton *)bt{
    GetBookBjModel *Model = self.BjArray[bt.tag -1000];
    
    CommentViewController *vc = [[CommentViewController alloc]init];
    vc.commentId = Model.bookId;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
//        return 40;
//    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
