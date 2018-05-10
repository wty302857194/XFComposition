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
#import "CorrectViewController.h"
#import "PlaceholderTextView.h"
#import "GetWritePicRemarkRequst.h"
#import "GetWritePicRemarkModel.h"
#import "KKImageEditorViewController.h"
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
//-(UICollectionView *)collectionView{
//    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
//        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//
//        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
//;
//        [_collectionView registerClass:[PicListCell class] forCellWithReuseIdentifier:@"cell"];
//
//    }
//    return _collectionView;
//}
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
    self.inputTextView.layer.borderWidth = 0.5;
    self.inputTextView.layer.borderColor = hexColor(888888).CGColor;
    self.inputTextView.layer.cornerRadius = 5;
    self.inputTextView.layer.masksToBounds = YES;
    [self getWritPic];
    
}
-(void)getWritPic{
    GetWritePicRequst *requst = [[GetWritePicRequst alloc]init];
    [requst GetWritePicRequstwithblogid:self.blogid :^(NSDictionary *json) {
        [self.picArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            GetWritePicModel *model = [GetWritePicModel loadWithJSOn:dic];
            [self.picArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    [[XFRequestManager sharedInstance] XFRequstGetStandard:_modelId addUser:[XFUserInfo getUserInfo].Loginid modelId:@"7" :^(NSString *requestName, id responseData, BOOL isSuccess) {
        if (isSuccess) {
            _dataArray = responseData;
            [_tableView reloadData];

        }else{
            
        }
        
    }];
    
}
#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PicListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PicListTableViewCell"];
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
        CorrectViewController *vc = [[CorrectViewController alloc]init];
    NSString *pic = [NSString stringWithFormat:@"%@",model.FixPicUrl];
    if (pic.length > 3){
       vc.PicUrl = model.FixPicUrl;
    }else{
       vc.PicUrl = model.PicUrl;
    }
    
        vc.PicID = model.ID;
    

        [self.navigationController pushViewController:vc animated:YES];
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
