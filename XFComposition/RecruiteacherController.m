//
//  RecruiteacherController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RecruiteacherController.h"
#import "ActivityDetailRequst.h"
#import "RecruiteacherFristCell.h"
#import "RecruiteacherSecondCell.h"
#import "HomePaFristheadView.h"
#import "ActivityDetailModel.h"

@interface RecruiteacherController ()<UICollectionViewDelegate,UICollectionViewDataSource,RecruiteacherFristCellDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *teacherArray;
@property (nonatomic,strong)ActivityDetailModel *model;

@end

@implementation RecruiteacherController
-(ActivityDetailModel *)model{
    if (!_model) {
        _model = [[ActivityDetailModel alloc]init];
    }
    return _model;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"活动详情";
    
    [self.view addSubview:self.collectionView];

//    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(detaiRequst)];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(detaiRequst)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;

    [self.collectionView.mj_header beginRefreshing];
    GO_BACK;
}
-(void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)detaiRequst{
    
    ActivityDetailRequst *requst = [[ActivityDetailRequst alloc]init];
    self.model = [[ActivityDetailModel alloc]init];
    
    [requst ActivityDetailwithActiveID:self.RecruitActiveID :^(NSDictionary *josn) {

        self.model = [ActivityDetailModel loadWithJSOn:josn[@"ret_data"]];

        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    }];
    

}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
//        layout.estimatedItemSize = CGSizeMake(WidthFrame, 340);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[RecruiteacherFristCell class] forCellWithReuseIdentifier:@"cell1"];
        [_collectionView registerClass:[RecruiteacherSecondCell class] forCellWithReuseIdentifier:@"cell2"];
        [_collectionView registerClass:[HomePaFristheadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _collectionView;
    
}

#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return  1;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RecruiteacherFristCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];

        
        cell.titleLabel.text = self.model.activeName;
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,self.model.activePic];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"mp322"] options:SDWebImageRefreshCached];
        cell.timeLabel.text = [NSString stringWithFormat:@"活动时间：%@~%@",[self.model.activeEndTime substringToIndex:9],[self.model.activeEndTime substringToIndex:9]];
         cell.xqlabel.text = @"活动详情：";
        cell.mingelabel.text = @"(限制10名额)";
//        cell.textView.text = [self.model.activeInfo stringByRemovingPercentEncoding];
        
        
        NSString * str1 = [self.model.activeInfo stringByRemovingPercentEncoding];
        
        //1.将字符串转化为标准HTML字符串
        str1 = [self htmlEntityDecode:str1];
        //2.将HTML字符串转换为attributeString
        NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
        
        //3.使用label加载html字符串
        cell.textView.attributedText = attributeStr;
        
        return cell;
    }else if (indexPath.section == 1){
        RecruiteacherSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        cell.activiID = self.RecruitActiveID;
        return cell;
    
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return CGSizeMake(WidthFrame, HeightFrame/4+200);
    }else
        return CGSizeMake(WidthFrame, HeightFrame/4*3-150);

}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 5, 0);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeZero;
    }else
        return CGSizeMake(WidthFrame, 30);
    
}
#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 1){
            HomePaFristheadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header1" forIndexPath:indexPath];
            headView.textLable.text = @"志愿者教师";
            return headView;
        }
        return nil;
    }
    return nil;
}

-(void)Submission{
    

}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
//去掉 HTML 字符串中的标签
- (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
