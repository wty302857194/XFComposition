//
//  TYCorrectViewController.m
//  XFComposition
//
//  Created by wbb on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "TYCorrectViewController.h"
#import "TYImageEditViewController.h"
#import "QiPaoTagView.h"

#import "SaveCommentCheckRequst.h"
#import "GetWritePicRemarkRequst.h"
#import "DeleteCommentCheckRequst.h"
#import "UploadPicRequst.h"

#import "GetWritePicRemarkModel.h"

@interface TYCorrectViewController ()<UIScrollViewDelegate>
{
    TYImageEditViewController * contentViewController;
}
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *rightView;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,strong) NSMutableArray *qiPaoArr;//旁批内容
@property (nonatomic,strong)NSMutableArray *remarkArray;
@property (nonatomic,strong)NSString *picnameurl;

@end

@implementation TYCorrectViewController
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kLayoutViewMarginTop, kScreenWidth, kScreenHeight - kLayoutViewMarginTop - kSafeAreaMaiginBottom)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(WidthFrame*3/2, _scrollView.height);
        _scrollView.scrollEnabled = NO;
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.width, _scrollView.height)];
        [_scrollView addSubview:_leftView];
        
        contentViewController = [[TYImageEditViewController alloc] init];
        contentViewController.PicUrl = self.PicUrl;
        contentViewController.view.frame = CGRectMake(0, 0, _leftView.width, _leftView.height);
        contentViewController.TYCorrecVC = self;
        [self addChildViewController:contentViewController];
        [_leftView addSubview:contentViewController.view];
        
        
        
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(_scrollView.width, 0, _scrollView.width/2.f, _scrollView.height)];
        
        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottomBtn setTitle:@"添 加" forState:UIControlStateNormal];
        [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bottomBtn.backgroundColor = [UIColor blueColor];
        [bottomBtn addTarget:self action:@selector(addPangPi) forControlEvents:UIControlEventTouchUpInside];
        [_rightView addSubview:bottomBtn];
        [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(40);
        }];
        [_scrollView addSubview:_rightView];
    }
    return _scrollView;
}
- (void)addPangPi {
    QiPaoTagView *qiPaoView = [[QiPaoTagView alloc] initWithFrame:CGRectMake(0, 200, 160, 50)];
     __weak typeof(self) weakSelf = self;
    qiPaoView.contentStrBlock = ^(NSString *contentStr) {
        [weakSelf.qiPaoArr addObject:contentStr];
    };
    [_rightView addSubview:qiPaoView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _qiPaoArr = [NSMutableArray arrayWithCapacity:0];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"保存批改" style:UIBarButtonItemStylePlain target:self action:@selector(tijiao)];
    self.navigationItem.rightBarButtonItem = item2;
    
    [self.view addSubview:self.scrollView];
    
    
//    [self GetWritePicRemark];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.x == 0) {
        scrollView.scrollEnabled = NO;
    }
}

//保存批改
-(void)tijiao {
    
   UIImage *image = [Global makeImageWithView:contentViewController.imgView withSize:contentViewController.imgView.size];
    UploadPicRequst *uploadPicRequst = [[UploadPicRequst alloc]init];
    NSData *imageData = UIImagePNGRepresentation(image);
    [uploadPicRequst UploadPicRequstWithfileValue:imageData withuserid:self.xf.Loginid withtypeid:@"1" :^(NSDictionary *json) {
        self.picnameurl = json[@"ret_data"];
    }];
    
    
    SaveCommentCheckRequst *requst = [[SaveCommentCheckRequst alloc]init];
    NSString *urlStr = @"";
    if (_picnameurl.length > 3) {
        urlStr = self.picnameurl;
    }else{
        urlStr = self.PicUrl;
    }
    [requst XFUpdateBlogPic:self.PicID fixpic:urlStr :^(NSDictionary *json) {
        
        
    }];
    
//    for (int i = 0; i<self.remarkArray.count; i++) {
//        GetWritePicRemarkModel *model = self.remarkArray[i];
//        DeleteCommentCheckRequst *requst = [[DeleteCommentCheckRequst alloc]init];
//        [requst DeleteCommentCheckRequstwithRemarkID:model.ID withuserid:self.xf.Loginid :^(NSDictionary *json) {
//            
//        }];
//        
//        
//    }
    
    
    
    for (QiPaoTagView *qiPaoView in self.scrollView.subviews) {
        if (qiPaoView.tag>0) {
            
            CGFloat H = (qiPaoView.frame.origin.y+64)/HeightFrame;
            CGFloat W = qiPaoView.frame.origin.x/WidthFrame*2;
            SaveCommentCheckRequst *requst = [[SaveCommentCheckRequst alloc]init];
            [requst SaveCommentCheckRequstWithRemarkID:@"0" withRemark:@"" withuserid:self.xf.Loginid withblogPicID:@"" withXLocation:[NSString stringWithFormat:@"%.2f",W] withYLocation:[NSString stringWithFormat:@"%.2f",H] :^(NSDictionary *json) {
                
            }];
            //显示批改成功
            
        }
        
    }
    
    
    
    
}



-(void)GetWritePicRemark{
    __weak typeof (self) weakSelf = self;
    //    GetWritePicModel *model = self.picArray[indexPath.row];
    GetWritePicRemarkRequst *requst = [[GetWritePicRemarkRequst alloc]init];
    [requst GetWritePicRemarkRequstwithpicid:self.PicID :^(NSDictionary *json) {
        [self.remarkArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            GetWritePicRemarkModel *model = [GetWritePicRemarkModel loadWithJSOn:dic];
            [weakSelf.remarkArray addObject:model];
        }
//        [self.tableView reloadData];
    }];
}

@end
