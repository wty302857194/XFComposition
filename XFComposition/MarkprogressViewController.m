//
//  MarkprogressViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MarkprogressViewController.h"
//#import "MarkProgressView.h"
#import "AddBookReadInfoRequst.h"
#import "GetBookBjInfoRequst.h"
#import "GetBookBjInfoModel.h"
#import "MarkProgressFristCell.h"
#import "MarkProgressSecondCell.h"
#import "MarkProgressThridCell.h"
@interface MarkprogressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UITextField *textfield1;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UITextField *textfield2;
@property (nonatomic,strong)UITextView *marktextView;
@property (nonatomic,strong)GetBookBjInfoModel *model;
@end

@implementation MarkprogressViewController
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MarkProgressFristCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[MarkProgressSecondCell class] forCellReuseIdentifier:@"cell2"];
        [_tableView registerClass:[MarkProgressThridCell class] forCellReuseIdentifier:@"cell3"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];

        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"标记进度";
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"3690CE"];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.markView];
    [self.view addSubview:self.tableView];
    
    if ([self.bjID isEqualToString:@""]) {
        [self.tableView reloadData];
    }else{
        [self GetBJinfo];
    
    }
    
}
-(void)GetBJinfo{
    
    GetBookBjInfoRequst *requst = [[GetBookBjInfoRequst alloc]init];
    [requst GetBookBjInfoRequstWithbjid:self.bjID :^(NSDictionary *json) {
        self.model = [[GetBookBjInfoModel alloc]init];
        self.model = [GetBookBjInfoModel loadWithJSOn:json[@"ret_data"]];
        
        [self.tableView reloadData];
    }];

}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 35;
    }else if (indexPath.row == 1){
    
        return 35;
    
    }else if (indexPath.row == 2){
    
        return HeightFrame-234;
    }
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        MarkProgressFristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        self.textfield1 = [[UITextField alloc]init];
        self.label1 = cell.pageLabel;
        self.textfield1 = cell.pageTextfield;
        self.label1.text = [NSString stringWithFormat:@"（总页数：%@）",self.PageStr];
        if (![self.bjID isEqualToString:@""]) {
            self.textfield1.text = [NSString stringWithFormat:@"%@",self.model.currentpage];
        }else{
            self.textfield1.text = nil;
        }
        
        return cell;
    }else if (indexPath.row == 1){
        MarkProgressSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        self.textfield2 = [[UITextField alloc]init];
        self.textfield2 = cell.titleTextfield;
        
        if (![self.bjID isEqualToString:@""]) {
            self.textfield2.text = [NSString stringWithFormat:@"%@",self.model.title];
        }else{
            self.textfield2.text = nil;
        }
        return cell;
        
    
    }else if (indexPath.row == 2){
        MarkProgressThridCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        self.marktextView = [[UITextView alloc]init];
        self.marktextView = cell.textView;
        if (![self.bjID isEqualToString:@""]) {
            self.marktextView.text = [NSString stringWithFormat:@"%@",self.model.content];
        }else{
            self.marktextView.text = nil;
        }
        return cell;
        

    }
    return nil;
}


#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 60;
    
}
#pragma mark - headeView内容
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 60)];
    backview.backgroundColor = [UIColor whiteColor];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(WidthFrame/4, 20, WidthFrame/2, 40);
    [bt setTitle:@"保存标记" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(MarkPogress) forControlEvents:UIControlEventTouchUpInside];
    bt.layer.cornerRadius = 6;
    bt.layer.masksToBounds = YES;
    [bt setBackgroundColor:[UIColor colorWithHexString:@"F1AF49"]];
    [backview addSubview:bt];
    return backview;
}
//标记进度
-(void)MarkPogress{
//    __weak typeof (self) weakSelf = self;
    AddBookReadInfoRequst *requst = [[AddBookReadInfoRequst alloc]init];
    [requst AddBookReadInfoRequstWithBookId:self.bookID withCurrentReadNum:self.textfield1.text withContentTag:self.textfield2.text withContent:self.marktextView.text withuserid:self.userId :^(NSDictionary *json) {

        if ([json[@"ret_code"] isEqualToString:@"0"]) {
            [SVProgressHUD showSuccessWithStatus:@"标记成功"];
            if (self.markprogressBlock) {
                self.markprogressBlock();
            }
            [self onBack];
        }else{
            [SVProgressHUD showErrorWithStatus:@"标记失败"];
        }
        
    }];
}


-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end
