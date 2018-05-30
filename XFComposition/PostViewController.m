//
//  PostViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/1.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PostViewController.h"
#import "GetTitleInfoRequst.h"
#import "GetTitleInforModel.h"
#import "GetTitleCommentRequst.h"
#import "GetTitleCommentModel.h"
#import "PostHeadview.h"
#import "PostCell.h"
#import "PostbackmyCell.h"
#import "GetTitleBackinfoModel.h"
#import "SaveCommentRequst.h"
#import "postcommentView.h"
@interface PostViewController ()<UITableViewDelegate,UITableViewDataSource,PostHeadviewDelegate,PostCellDelegate,postcommentViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)GetTitleInforModel *model;
@property (nonatomic,strong)NSMutableArray *btArray;
@property (nonatomic,strong)NSString *strType;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *commentArray;
@property (nonatomic,strong)PostHeadview *headview;
@property (nonatomic,strong)postcommentView *commentView;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,strong)NSString *backinfouserId;
@property (nonatomic,strong)NSString *istiezi;
@end

@implementation PostViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线

        [_tableView registerClass:[PostCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[PostbackmyCell class] forCellReuseIdentifier:@"cell2"];
        
    }
    return _tableView;
}
-(PostHeadview *)headview{
    if (!_headview) {
        _headview = [[PostHeadview alloc]init];
        _headview.delegate = self;
        self.btArray = _headview.btnArray;
    }
    return _headview;
}
-(GetTitleInforModel *)model{
    if (!_model) {
        _model = [[GetTitleInforModel alloc]init];
    }
    return _model;
}
-(NSMutableArray *)btArray{
    if (!_btArray) {
        _btArray = [NSMutableArray array];
    }
    return _btArray;
}
-(NSMutableArray *)commentArray{
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
-(postcommentView *)commentView{
    if (!_commentView) {
        _commentView = [[postcommentView alloc]initWithFrame:self.view.bounds];
        _commentView.delegate = self;
        [self.view addSubview:_commentView];
    }
    return _commentView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帖子详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.strType = @"0";
    self.istiezi = @"";
    self.page = 1;
    [self requstInfor:self.strid];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self GetTitleComment];
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        
        [self requstMore];
        [self.tableView.mj_footer endRefreshing];
    }];
    [self.view addSubview:self.headview];
    [self.view addSubview:self.tableView];
    self.headview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.headview.height);
//    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headview.frame), WidthFrame, HeightFrame-64-self.headview.height);
    self.tableView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.headview, 0).rightSpaceToView(self.view, 0).heightIs(300);
}
-(void)click:(UIButton *)bt{
    self.page = 1;
    for (UIButton *btn in self.btArray) {
        if (btn.tag == bt.tag) {
            [btn setTitleColor:[UIColor colorWithHexString:@"4892E2"] forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        if (btn.tag == 2000) {
            self.strType = @"0";
            
        }else if (btn.tag == 2001){
            self.strType = @"1";
            
        }else if (btn.tag == 2002){
            self.strType = @"2";
            
        }else if (btn.tag == 2003){
            self.strType = @"3";
        }
        [self GetTitleComment];
    }
    
}
//回复某人
-(void)clickMyps:(UIButton *)bt{
    NSLog(@"%ld",(long)bt.tag);
    [self.commentView showView];
    GetTitleCommentModel *model =  self.commentArray[bt.tag - 1000];
    NSLog(@"%@",model.commentid);
    self.backinfouserId = model.commentid;

}

//发表评论
-(void)clickfb :(UIButton *)bt{
    if (self.xf.Loginid == NULL) {
        [SVProgressHUD showInfoWithStatus:@"您还未登录"];
        return;
    }
    if ([self.istiezi isEqualToString:@"回复帖子"]) {
        self.backinfouserId = @"0";
    }
    //        SaveCommentRequst *requst = [[SaveCommentRequst alloc]init];
//        [requst SaveCommentRequstwithtitleId:self.strid withuserId:self.xf.Loginid withtypeFlag:@"0" withcommentInfo:self.commentView.textview.text :^(NSDictionary *json) {
//            if ([json[@"ret_code"] integerValue] == 0) {
//
//                [self GetTitleComment];
//                [SVProgressHUD showSuccessWithStatus:@"添加成功"];
//                [self.commentView dissMiss];
//                self.istiezi = @"";
//            }
//        }];
//    }else{
    NSLog(@"%@",self.backinfouserId);
        SaveCommentRequst *requst = [[SaveCommentRequst alloc]init];
        [requst SaveCommentRequstwithtitleId:self.strid withuserId:self.xf.Loginid withtypeFlag:self.backinfouserId withcommentInfo:self.commentView.textview.text :^(NSDictionary *json) {
            if ([json[@"ret_code"] integerValue] == 0) {
                
                [self GetTitleComment];
                [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                [self.commentView dissMiss];
                self.istiezi = @"";
            }
        }];
//    }
    
}
//回复帖子
-(void)pingluntiezi{
    self.istiezi = @"回复帖子";
    [self.commentView showView];
    
    
}
-(void)requstInfor :(NSString *)postId{
    
    
    GetTitleInfoRequst *requst = [[GetTitleInfoRequst alloc]init];
    [requst GetTitleInfoRequstwithid:postId :^(NSDictionary *json) {
        self.model = [[GetTitleInforModel alloc]init];
        self.model = [GetTitleInforModel loadWithJSOn:json[@"ret_data"]];
        
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,self.model.UserPic];
        [self.headview.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"xf_Norecord"] options:SDWebImageRefreshCached];
        self.headview.titleLabel.text = self.model.Title;
        self.headview.timeLabel.text = self.model.AddTime;
        [self.headview.bt1 setTitle:self.model.UserName forState: UIControlStateNormal];
        [self.headview.bt1 setTitle:[NSString stringWithFormat:@"浏览(%@)",self.model.VisitedTime] forState: UIControlStateNormal];
        NSString * str1 = [self.model.ContentInfo stringByRemovingPercentEncoding];
        
        //1.将字符串转化为标准HTML字符串
        str1 = [self htmlEntityDecode:str1];
        //2.将HTML字符串转换为attributeString
        NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
        self.headview.txtLabel.attributedText = attributeStr;
    }];
    
}
-(void)eneas{
    
}
-(void)GetTitleComment{
    
    GetTitleCommentRequst *requst = [[GetTitleCommentRequst alloc]init];
    [requst GetTitleCommentRequstwithtitleId:self.strid withmasterId:@"0" withPageIndex:@"1" withPageSize:@"20" withmasteOnly:@"0" withorderFlag:self.strType :^(NSDictionary *json) {
        [self.commentArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetTitleCommentModel *model = [GetTitleCommentModel loadWithJSOn:dic];
            [self.commentArray addObject:model];
        }
        [self.tableView reloadData];
        
    }];
    
}
-(void)requstMore{
    self.page +=1;
    GetTitleCommentRequst *requst = [[GetTitleCommentRequst alloc]init];
    [requst GetTitleCommentRequstwithtitleId:self.strid withmasterId:@"0" withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withmasteOnly:@"0" withorderFlag:self.strType :^(NSDictionary *json) {
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetTitleCommentModel *model = [GetTitleCommentModel loadWithJSOn:dic];
            [self.commentArray addObject:model];
        }
        [self.tableView reloadData];

    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.commentArray.count;
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GetTitleCommentModel *model = self.commentArray[section];
    return 1 + model.backInfo.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GetTitleCommentModel *Model = self.commentArray[indexPath.section];
    if (indexPath.row == 0) {
        
        return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[PostCell class] contentViewWidth:[self cellContentViewWith]];
    }else{

        if (Model.backInfo.count>0) {
        GetTitleBackinfoModel *Model2 = [GetTitleBackinfoModel loadWithJSOn:Model.backInfo[indexPath.row-1]];
        return [self.tableView cellHeightForIndexPath:indexPath model:Model2 keyPath:@"model" cellClass:[PostbackmyCell class] contentViewWidth:[self cellContentViewWith]];
        }

    }
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetTitleCommentModel *Model = self.commentArray[indexPath.section];
    if (indexPath.row == 0) {
        
        PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.bt.tag = 1000+indexPath.section;
        cell.louLabel.text = [NSString stringWithFormat:@"%ldL",(long)indexPath.section+1];
        cell.model = Model;
        return cell;
    }else{

        
        if (Model.backInfo.count>0) {
            PostbackmyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

          GetTitleBackinfoModel *Model2 = [GetTitleBackinfoModel loadWithJSOn:Model.backInfo[indexPath.row-1]];
            cell.model = Model2;

            return cell;
        }
        
    }
    return nil;
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 20;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 20)];
//    view.backgroundColor = [UIColor redColor];
    GetTitleCommentModel *Model = self.commentArray[section];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(66, 0, WidthFrame-66, 20)];
    label.textColor = [UIColor colorWithHexString:@"3A9DE3"];
    if (Model.backInfo.count>0) {
        label.text = [NSString stringWithFormat:@"共%lu条回复",(unsigned long)Model.backInfo.count];
    }
    
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    return view;
}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}


- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

@end
