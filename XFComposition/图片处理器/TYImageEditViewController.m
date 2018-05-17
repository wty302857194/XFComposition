//
//  TYImageEditViewController.m
//  MyPracticeViewController
//
//  Created by wbb on 2018/5/11.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "TYImageEditViewController.h"
#import "XFCorrectViewController.h"
#import "DCCommon.h"
#import "DCBezierPaintBoard.h"
//#import "DCOpenGLDrawView.h"
#import "ListSelectView.h"
#import "DCUndoBeziPathPaintBoard.h"
#import "TKImageView.h"
#import "ActionSheetView.h"
#import "UploadPicRequst.h"
#import "AudioRecordView.h"
#import "AudioView.h"
#import "StrokeView.h"
#import "XFLbraryViewController.h"
@interface TYImageEditViewController ()
{
    CGFloat lastScale;
    CGRect oldFrame;    //保存图片原来的大小
    CGRect largeFrame;  //确定图片放大最大的程;
    UIPinchGestureRecognizer *pinchGestureRecognizer;
    UIPanGestureRecognizer *panGestureRecognizer;
    UIImage *_image;
    BOOL _isShouHui;
}
@property (nonatomic, assign)DCPaintColor  selectPaintColor;
@property (nonatomic, assign) BOOL isErase;
@property (nonatomic, assign) DCPaintBoardType paintBoardType;

@property (strong, nonatomic) DCBezierPaintBoard *DCUndoView;
@property (weak, nonatomic) IBOutlet UIView *topBackView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tabArr;
@property (nonatomic, strong) NSMutableArray * colorArray;
@property (nonatomic, strong) NSMutableArray * widthArray;
@property (weak, nonatomic) IBOutlet UIButton *clipButton;

@property (nonatomic, strong) TKImageView *tkImageView;
@property (nonatomic, strong)AudioRecordView * recordView;
@property (nonatomic, strong) StrokeView * strokeView;

@end

@implementation TYImageEditViewController
- (IBAction)yuYin:(UIButton *)sender {
    switch (sender.tag) {
        case 10://语音
        {
            [self.recordView  showAudioRecordView];
        }
            break;
        case 11://截图
        {
            _image = [Global makeImageWithView:self.imgView withSize:self.imgView.size];

            self.imgView.hidden = NO;
            [self.view addSubview:self.tkImageView];
            self.clipButton.hidden = NO;
            
        }
            break;
        case 12://旁批
        {
            [UIView animateWithDuration:0.5 animations:^{
                [self.TYCorrecVC.scrollView setContentOffset:CGPointMake(kScreenWidth/2.f, self.TYCorrecVC.scrollView.contentOffset.y)];
                self.TYCorrecVC.scrollView.scrollEnabled = YES;
            }];
        }
            break;
        case 13://手绘
        {
            sender.selected = !sender.selected;
            _isShouHui = sender.selected;
            if (sender.isSelected) {
                
            }else {
                self.DCUndoView.lineColor = [UIColor clearColor];
            }
            [self chooseGestureRecognizer];
        }
            break;
        case 14://橡皮檫
        {
            
            sender.selected = !sender.selected;
            self.isErase = sender.selected;
            [self chooseGestureRecognizer];
        }
            break;
        case 15://tableview
        {
            self.tableView.hidden = !self.tableView.hidden;
        }
            break;
        default:
            break;
    }
}
- (void)chooseGestureRecognizer {
    if (_isErase||_isShouHui) {
        [self removeGestureRecognizerFromView:self.imgView];
    }else {
        [self addGestureRecognizerToView:self.imgView];
    }
}

- (IBAction)clipImage:(id)sender {
    
    [self.tkImageView removeFromSuperview];
    self.clipButton.hidden = YES;
    self.imgView.hidden = NO;
    _image = [self.tkImageView currentCroppedImage];

    ActionSheetView * actionSheet = [[ActionSheetView alloc] initWithCancleTitle:@"取消" otherTitles:@"范文库",@"病文库" ,nil];
    
    [actionSheet show];
    actionSheet.actionSheetBlock = ^(ActionSheetItem *sheetItem) {
        
        NSData * imageData = nil;
        
        if (UIImagePNGRepresentation(_image)) {
            imageData = UIImagePNGRepresentation(_image);
        }else {
            imageData = UIImageJPEGRepresentation(_image, 0.2);
        }
        UploadPicRequst *requst = [[UploadPicRequst alloc]init];
        [requst UploadPicRequstWithfileValue:imageData withuserid:[XFUserInfo getUserInfo].Loginid withtypeid:@"1" :^(NSDictionary *json){
            NSString * str =   json[@"ret_data"]?:@"";
            
            [[XFRequestManager sharedInstance] XFRequstAddCutPic:[XFUserInfo getUserInfo].Loginid PicID:_picModel.PicID blogID:_picModel.BlogID ExtractPicUrl:str ExtractContent:@"" ExtractType:[NSString stringWithFormat:@"%ld",(long)sheetItem.index] :^(NSString *requestName, id responseData, BOOL isSuccess) {

                [SVProgressHUD showInfoWithStatus:responseData];
                
            }];
            
        }];
    };
    
}
-(AudioRecordView *)recordView{
    
    __weak typeof(self)  weakSelf = self;
    
    if (_recordView == nil) {
        _recordView = [[NSBundle mainBundle] loadNibNamed:@"AudioRecordView" owner:self options:nil].lastObject;
        _recordView.recordViewBlock = ^(id recordFileUrl) {
            
            
            
            [[XFRequestManager sharedInstance] XFRequstUploadAudio:[XFUserInfo getUserInfo].Loginid  fileValue:recordFileUrl :^(NSString *requestName, id responseData, BOOL isSuccess) {
                if (isSuccess) {
                    [weakSelf creatAudioView:[NSString stringWithFormat:@"%@%@",HTurl,responseData]];
                }
            }] ;
        };
    }
    return _recordView;
}
//创建多个
-(void)creatAudioView:(NSString*)urlStr{
    
    AudioView * view = [[NSBundle mainBundle] loadNibNamed:@"AudioView" owner:self options:nil].lastObject;
    view.tapBlock = ^{
//        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//        AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL URLWithString:urlStr]];
//        AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
//        
//        AVPlayer*  player = [AVPlayer playerWithPlayerItem:item];
//        [player play];
        
        
        NSURL * url  = [NSURL URLWithString:urlStr];
        AVPlayerItem * songItem = [[AVPlayerItem alloc]initWithURL:url];
        AVPlayer * player = [[AVPlayer alloc]initWithPlayerItem:songItem];
        [player play];
    };
    view.panBlock = ^(CGPoint point) {
        
    };
    
    [self.view addSubview:view];
    
}
- (TKImageView *)tkImageView
{
    if (!_tkImageView) {
        _tkImageView = [[TKImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height-50-60)];
        //需要进行裁剪的图片对象
//        _tkImageView.toCropImage = _image;
        //是否显示中间线
        //    _tkImageView.showMidLines = YES;
        //是否需要支持缩放裁剪
        _tkImageView.needScaleCrop = YES;
        //是否显示九宫格交叉线
        //    _tkImageView.showCrossLines = YES;
        _tkImageView.cornerBorderInImage = NO;
        _tkImageView.cropAreaCornerWidth = 10;
        _tkImageView.cropAreaCornerHeight = 10;
        _tkImageView.minSpace = 5;
        _tkImageView.cropAreaCornerLineColor = [UIColor redColor];
        _tkImageView.cropAreaBorderLineColor = [UIColor lightGrayColor];
//        _tkImageView.cropAreaCornerLineWidth = 6;
        _tkImageView.cropAreaBorderLineWidth = 1;
        _tkImageView.cropAreaMidLineWidth = 20;
//        _tkImageView.cropAreaMidLineHeight = 6;
        _tkImageView.cropAreaMidLineColor = [UIColor whiteColor];
        _tkImageView.cropAreaCrossLineColor = [UIColor whiteColor];
        _tkImageView.cropAreaCrossLineWidth = 0.5;
        _tkImageView.initialScaleFactor = .8f;
        _tkImageView.cropAspectRatio = 0;
        
    }
    return _tkImageView;
}


- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 80, kScreenWidth-100, (kScreenWidth-100)*2083/1602.f)];
        _imgView.backgroundColor = hexColor(ff4e00);
        [_imgView setMultipleTouchEnabled:YES];
        [_imgView setUserInteractionEnabled:YES];
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,self.PicUrl];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:str] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            _image = image;
//            _image = [Global makeImageWithView:self.imgView withSize:self.imgView.size];
        }];
        _topBackView.clipsToBounds = YES;
        [_topBackView addSubview:_imgView];

        oldFrame = _imgView.frame;
        largeFrame = CGRectMake(-(3 * oldFrame.size.width - self.view.height)/2.f, -(3 * oldFrame.size.height - self.view.height)/2.f, 3 * oldFrame.size.width, 3 * oldFrame.size.height);
        
        
        _DCUndoView = [[DCBezierPaintBoard alloc] init];
        _DCUndoView.lineColor = [UIColor clearColor];
        _DCUndoView.backgroundColor = [UIColor clearColor];
        [_imgView addSubview:_DCUndoView];
        [_DCUndoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_imgView);
        }];
    }
    return _imgView;
}
-(StrokeView*)strokeView{
    
    
    if (_strokeView == nil) {
        
        __weak typeof(self) weakSelf = self;
        _strokeView = [[NSBundle mainBundle] loadNibNamed:@"StrokeView" owner:self options:nil].lastObject;
        _strokeView.layer.cornerRadius = 6.0;
        _strokeView.layer.masksToBounds = YES;
        _strokeView.strokeViewBlcok = ^(int arguments,BOOL isSetColor) {
            
            if (isSetColor) {
                
                [weakSelf setSelectPaintColor:arguments+1];
            }else{
                weakSelf.DCUndoView.lineWidth = arguments+1;
            }
            
        };
        
    }
    return _strokeView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tabArr = @[@"清屏",@"颜色",@"画笔",@"还原大小",@"范文库",@"病文库",@"撤销"];
    self.clipButton.hidden = YES;
    [self addGestureRecognizerToView:self.imgView];
    _colorArray = [NSMutableArray array];
    _widthArray = [NSMutableArray array];
    self.DCUndoView.lineColor = [UIColor redColor];
    for (int i =0 ; i< @[@"红色",@"绿色",@"白色"].count; i++) {
        StandardInfo * bean = [[StandardInfo alloc]init];
        NSString * str = @[@"红色",@"绿色",@"白色"][i];
        bean.StandardText = str;
        if (i == 0) {
            bean.isSelected = YES;
        }
        [_colorArray addObject:bean];
    }
    
    for (int i =0 ; i< @[@"细",@"中",@"粗"].count; i++) {
        StandardInfo * bean = [[StandardInfo alloc]init];
        NSString * str = @[@"细",@"中",@"粗"][i];
        bean.StandardText = str;
        if (i == 0) {
            bean.isSelected = YES;
        }
        [_widthArray addObject:bean];
    }
    

}
//取消手势
- (void)removeGestureRecognizerFromView:(UIView *)view {
    [view removeGestureRecognizer:pinchGestureRecognizer];
    [view removeGestureRecognizer:panGestureRecognizer];
}
//添加手势
// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    // 缩放手势
    pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}
// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
//        if (self.imgView.frame.size.width < oldFrame.size.width) {
//            self.imgView.frame = oldFrame;
//            //让图片无法缩得比原图小
//        }
//        if (self.imgView.frame.size.width > 3 * oldFrame.size.width) {
//            self.imgView.frame = largeFrame;
//        }
        pinchGestureRecognizer.scale = 1;
    }
}
/**
 *  画笔颜色set方法
 *
 */
- (void)setSelectPaintColor:(DCPaintColor)selectPaintColor
{
    _selectPaintColor = selectPaintColor;
    switch (selectPaintColor) {
        case DCPaintColorRed:
            self.DCUndoView.lineColor = [UIColor redColor];
            break;
        case DCPaintColorwhite:
            self.DCUndoView.lineColor = [UIColor whiteColor];
            break;
        case DCPaintColorGreen:
            self.DCUndoView.lineColor = [UIColor greenColor];
            break;
        default:
            self.DCUndoView.lineColor = [UIColor redColor];
            break;
    }
}
- (void)setIsErase:(BOOL)isErase{
    _isErase = isErase;
    self.DCUndoView.isErase = isErase;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tabArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _tabArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView.hidden = YES;

    switch (indexPath.row) {
        case 0:
        {
            [self.DCUndoView clear];
        }
            break;
        case 1:
        {
            [self.strokeView showStrokeView:_colorArray isSetColor:YES];

        }
            break;

        case 2:
        {
            [self.strokeView showStrokeView:_widthArray isSetColor:NO];

        }
            break;
        case 3:
        {
            self.imgView.frame = oldFrame;
        }
            break;
        case 4:
        {
            [[XFRequestManager sharedInstance] XFRequstGetCutPicBlog:[XFUserInfo getUserInfo].Loginid blogID:_picModel.BlogID ExtractType:@"0" :^(NSString *requestName, id responseData, BOOL isSuccess) {
                if (isSuccess) {
                    XFLbraryViewController * vc = [[XFLbraryViewController alloc]init];
                    
                    vc.dataArray = responseData;
                    
                    [self.TYCorrecVC.navigationController pushViewController:vc animated:YES];
                }
            }] ;
            
        }
            break;
        case 5:
        {
            [[XFRequestManager sharedInstance] XFRequstGetCutPicBlog:[XFUserInfo getUserInfo].Loginid blogID:_picModel.BlogID ExtractType:@"1" :^(NSString *requestName, id responseData, BOOL isSuccess) {
                if (isSuccess) {
                    XFLbraryViewController * vc = [[XFLbraryViewController alloc]init];
                    
                    vc.dataArray = responseData;
                    
                    [self.TYCorrecVC.navigationController pushViewController:vc animated:YES];
                }
            }] ;
            
        }
            break;
        case 6:
        {
            self.tableView.hidden = NO;

            [self.DCUndoView cheXiao];
        }
            break;
        default:
            break;
    }
    
}

@end
