//
//  ReadJianCeViewController.m
//  XFComposition
//
//  Created by wbb on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "ReadJianCeViewController.h"
#import "ReadnotesViewController.h"
#import "MyrecommendBookViewController.h"
#import "BookDetailViewController.h"
#import "TakenotesViewController.h"

#import "BookRecCell.h"

#import "BookModel.h"
#import "GetBookListRequst.h"

@interface ReadJianCeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource> {
    XFUserInfo *_userInfo;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *bookArray;
@end

@implementation ReadJianCeViewController
- (IBAction)zuoTiBiji:(UIButton *)sender {
    TakenotesViewController *vc = [[TakenotesViewController alloc]init];
    vc.takenotesuserId = _userInfo.Loginid;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)readBiJi:(UIButton *)sender {
    ReadnotesViewController *vc = [[ReadnotesViewController alloc]init];
    vc.readnotesUserid = _userInfo.Loginid;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)myTuiJian:(UIButton *)sender {
    MyrecommendBookViewController *vc = [[MyrecommendBookViewController alloc]init];
    vc.MyrecommenuserId = _userInfo.Loginid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"阅读检测";
    _userInfo = [XFUserInfo getUserInfo];
    self.bookArray = [NSMutableArray arrayWithCapacity:0];
    self.view.backgroundColor = hexColor(f4f5f6);
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[BookRecCell class] forCellWithReuseIdentifier:@"bookreccell"];
    
    
    if ([_isTeacher isEqualToString:@"1"]) {
        self.topViewLayout.constant = 81;
        self.oneViewLayout.constant = 0;
        self.oneView.hidden = YES;
    }
    
    [self GetBookList];
}
//获取图书列表
-(void)GetBookList {
    GetBookListRequst *requst = [[GetBookListRequst alloc]init];
    [requst GetBookListRequstWithPageIndex:@"1" withPageSize:@"20" withchaperid:@"" withauthor:@"" withkeyword:@"" withbooktype:@"0" withisdaodu:@"" withistuijian:@"0" withishost:@"0" withquxian:@"" withxuexiao:@"" :^(NSDictionary *json) {
        
        [self.bookArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            BookModel *model = [BookModel loadWithJSOn:dic];
            [self.bookArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.bookArray.count;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookRecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bookreccell" forIndexPath:indexPath];
    BookModel *model = self.bookArray[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@",model.BookPic];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"xf_Norecord"] options:SDWebImageRefreshCached];
    cell.titleLabel.text = [NSString stringWithFormat:@"《%@》",model.BookName];
    cell.timeLabel.text = [NSString stringWithFormat:@"推荐时间：%@",model.BookAddTime];
    cell.chubanLabel.text = [NSString stringWithFormat:@"出版社：%@",model.BookPublic];
    cell.authorLabel.text = [NSString stringWithFormat:@"作者：%@",model.BookAuthor];
    cell.gradeLabel.text = [NSString stringWithFormat:@"年级：%@",model.Booktypename];
    cell.numLabel.text = [NSString stringWithFormat:@"阅读次数：%@",model.BookAttirbute1];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(WidthFrame/2-0.5, 140);
    
}
// 设置最小行间距，也就是前一行与后一行的中间最小间隔  行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
//横向
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_userInfo.Loginid == NULL) {
        [SVProgressHUD showInfoWithStatus:@"您还未登录"];
        return;
    }
    BookDetailViewController *vc = [[BookDetailViewController alloc]init];
    BookModel *model = self.bookArray[indexPath.row];
    vc.bookid = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
