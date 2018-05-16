//
//  PicListViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PicListViewController.h"
#import "PicListCell.h"
#import "GetWritePicRequst.h"
#import "GetWritePicModel.h"
#import "PicListTableViewCell.h"
#import "TYCorrectViewController.h"
#import "PlaceholderTextView.h"
#import "GetWritePicRemarkRequst.h"
#import "GetWritePicRemarkModel.h"
#import "KKImageEditorViewController.h"
#import "XFCorrectViewController.h"

@interface PicListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,KKImageEditorDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)  IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *picArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;;

@property (strong, nonatomic) IBOutlet PlaceholderTextView *inputTextView;
@end

@implementation PicListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    
    manager.enableAutoToolbar = YES;//这个是它自带键盘工具条开关
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    
    manager.enableAutoToolbar = NO;//这个是它自带键盘工具条开关
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
-(NSMutableArray *)picArray{
    if (!_picArray) {
        _picArray = [[NSMutableArray alloc]init];
    }
    return _picArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的作文";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [NSMutableArray array];
    
    [_tableView registerNib:[UINib nibWithNibName:@"PicListTableViewCell" bundle:nil] forCellReuseIdentifier:@"PicListTableViewCell"];
    [_collectionView registerClass:[PicListCell class] forCellWithReuseIdentifier:@"cell"];
    self.inputTextView.font = [UIFont systemFontOfSize:13];
    self.inputTextView.delegate = self;
    self.inputTextView.PlaceholderLabel.text = @"请输入总评";
    self.inputTextView.placeholderColor =hexColor(cccccc) ;
    self.inputTextView.placeholderFont = [UIFont systemFontOfSize:13];
    self.inputTextView.textColor =hexColor(666666);
    self.inputTextView.editable = _isChange;
    self.inputTextView.layer.borderWidth = 0.5;
    self.inputTextView.layer.borderColor = hexColor(e5e5e5).CGColor;
    self.inputTextView.layer.cornerRadius = 5;
    self.inputTextView.layer.masksToBounds = YES;
    [self getWritPic];
    
}
-(void)getWritPic{
    
    
    [[XFRequestManager sharedInstance] XFRequstGetWritePicCheckList:self.blogid userID:[XFUserInfo getUserInfo].Loginid isChange:_isChange :^(NSString *requestName, id responseData, BOOL isSuccess) {
        
        if (isSuccess) {
            self.picArray = responseData;
            [_collectionView reloadData];
        }else{
            
            
        }
        
    }];
   
    [[XFRequestManager sharedInstance] XFRequstGetBlogStandard:self.blogid userID:[XFUserInfo getUserInfo].Loginid  :^(NSString *requestName, id responseData, BOOL isSuccess) {
        if (isSuccess) {
            _dataArray = responseData;
            [_tableView reloadData];

        }else{
            
        }
        
    }];
    
    [[XFRequestManager sharedInstance] XFRequstGetBlogComment:self.blogid userID:[XFUserInfo getUserInfo].Loginid  :^(NSString *requestName, id responseData, BOOL isSuccess) {
        if (isSuccess) {
            CommentInfo * info = (CommentInfo*)responseData;
            _inputTextView.text = info.CommentsAttribute2;
        }
        
    }];
}
#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PicListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PicListTableViewCell"];
    cell.isChange = _isChange;
    [cell reloadData:_dataArray[indexPath.row]];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.picArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PicListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    GetWritePicModel *model = self.picArray[indexPath.row];
    cell.model = model;
//    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.PicUrl];
//    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
    return cell;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WidthFrame/3-30, 130);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    return UIEdgeInsetsMake(2, 15, 2, 15);
}

-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    GetWritePicModel *model = self.picArray[indexPath.row];

//    TYCorrectViewController *vc = [[TYCorrectViewController alloc]init];
//    vc.picModel = model;
//    [self.navigationController pushViewController:vc animated:YES];

    XFCorrectViewController * VC = [[XFCorrectViewController alloc]init];
    VC.PicUrl = model.PicUrl;
    VC.PicID = model.PicID;
    
    [self.navigationController pushViewController:VC animated:YES];
    
    
    //手机版获取文章图片点评内容
   
    
//    GetWritePicModel *model = self.picArray[indexPath.row];
//
//    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.PicUrl];
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
//    UIImage *image = [UIImage imageWithData:data];
//
//    KKImageEditorViewController *editor = [[KKImageEditorViewController alloc] initWithImage:image delegate:self];
//
//    [self.navigationController pushViewController:editor animated:YES];
    
//    GetWritePicModel *model = self.picArray[indexPath.row];
    
    
}

#pragma mark- KKImageEditorDelegate

- (void)imageDidFinishEdittingWithImage:(UIImage *)image
{
    NSLog(@"tupian");
}


@end
