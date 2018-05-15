//
//  CorrectViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "CorrectViewController.h"
#import "ImageView.h"
//#import "toolbarView.h"
#import "SaveCommentCheckRequst.h"
#import "GetWritePicRemarkRequst.h"
#import "GetWritePicRemarkModel.h"

#import "DeleteCommentCheckRequst.h"

#import "KKImageEditorViewController.h"
#import "UploadPicRequst.h"
@interface CorrectViewController ()<ImageViewDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,KKImageEditorDelegate>
@property (nonatomic,strong)ImageView *imgView;
//@property (nonatomic,strong)toolbarView *toolView;

@property (nonatomic,strong)UIScrollView *scorllView;
@property (nonatomic,assign)CGPoint current;

@property (nonatomic,assign)CGRect oldFrame;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,strong)NSMutableArray *remarkArray;
@property (nonatomic,copy) NSString *picnameurl;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation CorrectViewController

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, WidthFrame, HeightFrame) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightFrame-64;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell addSubview:self.scorllView];
    [self hhee];
    return  cell;
    
    
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}
-(UIScrollView *)scorllView{
    if (!_scorllView) {
        _scorllView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        self.oldFrame = _scorllView.frame;
        _scorllView.contentSize = CGSizeMake(WidthFrame*3/2, HeightFrame-64);
        _scorllView.pagingEnabled = YES;//设置整屏滚动
        _scorllView.bounces = YES;//设置边缘无弹跳
        //添加点按击手势监听器
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUiscrollView:)];
        //设置手势属性
        tapGesture.delegate = self;
        tapGesture.numberOfTapsRequired=1;//设置点按次数，默认为1，注意在iOS中很少用双击操作
        tapGesture.numberOfTouchesRequired=1;//点按的手指数
        [_scorllView addGestureRecognizer:tapGesture];
        _scorllView.delaysContentTouches = NO;
        UIButton *addBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBt setTitle:@"添加" forState:UIControlStateNormal];
        addBt.backgroundColor = [UIColor colorWithHexString:@"348DCC"];
        addBt.frame = CGRectMake(WidthFrame+WidthFrame/8, HeightFrame-40-64, WidthFrame/4, 30);
        addBt.layer.cornerRadius = 4;
        [addBt addTarget:self action:@selector(creatView) forControlEvents:UIControlEventTouchUpInside];
        addBt.layer.masksToBounds = YES;
        [_scorllView addSubview:addBt];
        
        UIButton *addBt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBt1 setTitle:@"编辑图片" forState:UIControlStateNormal];
        addBt1.backgroundColor = [UIColor colorWithHexString:@"348DCC"];
        addBt1.frame = CGRectMake(WidthFrame+WidthFrame/8, HeightFrame-40-64-40, WidthFrame/4, 30);
        addBt1.layer.cornerRadius = 4;
        [addBt1 addTarget:self action:@selector(creatView1) forControlEvents:UIControlEventTouchUpInside];
        addBt1.layer.masksToBounds = YES;
        [_scorllView addSubview:addBt1];
        
        _picnameurl = @"";
        
    }
    return _scorllView;
}
//-(toolbarView *)toolView{
//    if (!_toolView) {
//        _toolView = [[toolbarView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-90, self.view.frame.size.height/4, 180, 140)];
//        _toolView.backgroundColor = [UIColor lightGrayColor];
//        _toolView.delegate = self;
//        [self.view addSubview:_toolView];
//    }
//    return _toolView;
//}

-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
-(NSMutableArray *)remarkArray{
    if (!_remarkArray) {
        _remarkArray = [[NSMutableArray alloc]init];
    }
    return _remarkArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"学生习作";
    
    [self getPic];
    [self GetWritePicRemark];
    [self leftBarButton];
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
        [self.tableView reloadData];
    }];
}
-(void)hhee{
    
    

    for (int i = 0; i<self.remarkArray.count; i++) {
        GetWritePicRemarkModel *model = self.remarkArray[i];
        
        ImageView *imgView = [[ImageView alloc]init];
//        CGFloat h = [self heightForString:imgView.textView andWidth:WidthFrame/2-15];
        
        imgView.frame = CGRectMake(WidthFrame+15, [model.YLocation floatValue]*(HeightFrame-64), WidthFrame/2-15, 30);
        imgView.tag = i+1000;
        imgView.delegate =self;
        imgView.textView.text = model.Remark;
        [self.scorllView addSubview:imgView];
        
        
    }
    
}
- (float) heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}


//获取照片
-(void)getPic{
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,self.PicUrl];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
    UIImage *image = [UIImage imageWithData:data];
//    NSLog(@"w = %f,h = %f",image.size.width,image.size.height);

    UIImageView *picImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame-64)];
    
//    KKImageEditorViewController *editor = [[KKImageEditorViewController alloc] initWithImage:image delegate:self];
//
//
//    [self.navigationController pushViewController:editor animated:YES];
    picImageview.image = image;

    [self.scorllView addSubview:picImageview];


}
//保存批改
-(void)tijiao{
    
    SaveCommentCheckRequst *requst = [[SaveCommentCheckRequst alloc]init];
    if (_picnameurl.length > 3){
        [requst XFUpdateBlogPic:self.PicID fixpic:self.picnameurl :^(NSDictionary *json) {
            
            
        }];
    }else{
        [requst XFUpdateBlogPic:self.PicID fixpic:self.PicUrl :^(NSDictionary *json) {
            
            
        }];
    }


    for (int i = 0; i<self.remarkArray.count; i++) {
        GetWritePicRemarkModel *model = self.remarkArray[i];
        DeleteCommentCheckRequst *requst = [[DeleteCommentCheckRequst alloc]init];
        [requst DeleteCommentCheckRequstwithRemarkID:model.ID withuserid:self.xf.Loginid :^(NSDictionary *json) {

        }];


    }



    for (ImageView *imgview in self.scorllView.subviews) {
        if (imgview.tag>0) {

            CGFloat H = (imgview.frame.origin.y+64)/HeightFrame;
            CGFloat W = imgview.frame.origin.x/WidthFrame*2;
            SaveCommentCheckRequst *requst = [[SaveCommentCheckRequst alloc]init];
            [requst SaveCommentCheckRequstWithRemarkID:@"0" withRemark:imgview.textView.text withuserid:self.xf.Loginid withblogPicID:self.PicID withXLocation:[NSString stringWithFormat:@"%.2f",W] withYLocation:[NSString stringWithFormat:@"%.2f",H] :^(NSDictionary *json) {

            }];
            //显示批改成功

        }

    }
    

   

}
-(void)showAlter :(ImageView *)imgView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除批注" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [imgView removeFromSuperview];
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}
//实现代理
-(void)doSomething:(UIButton *)bt{
    if (bt.tag == 1005) {
        [self creatView];
    }
    
}

//响应点击手势
-(void)tapUiscrollView:(UITapGestureRecognizer *)gesture{
    self.current = [gesture locationInView:self.scorllView];//获取当前坐标
    NSLog(@"y :%f",self.current.y);
    
}

- (void)creatView1{
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,self.PicUrl];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
        UIImage *image = [UIImage imageWithData:data];
    
        KKImageEditorViewController *editor = [[KKImageEditorViewController alloc] initWithImage:image delegate:self];
    
        [self.navigationController pushViewController:editor animated:YES];
}



//点击创建多个评论框
int i= 0;
-(void)creatView{
    i++;
    
    ImageView *imgView = [[ImageView alloc]init];
    imgView.tag = i;
    imgView.delegate =self;
    [self.scorllView addSubview:imgView];
    
    imgView.frame = CGRectMake(WidthFrame+15, HeightFrame/2-32, WidthFrame/2-15, 30);

}

-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"保存批改" style:UIBarButtonItemStylePlain target:self action:@selector(tijiao)];
    self.navigationItem.rightBarButtonItem = item2;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark- KKImageEditorDelegate

- (void)imageDidFinishEdittingWithImage:(UIImage *)image
{
    UIImageView *picImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame-64)];
    
        KKImageEditorViewController *editor = [[KKImageEditorViewController alloc] initWithImage:image delegate:self];
    //
    //
    //    [self.navigationController pushViewController:editor animated:YES];
    picImageview.image = image;
    
    [self.scorllView addSubview:picImageview];
    
    UploadPicRequst *requst = [[UploadPicRequst alloc]init];
    NSData *imageData = UIImagePNGRepresentation(image);
    [requst UploadPicRequstWithfileValue:imageData withuserid:self.xf.Loginid withtypeid:@"1" :^(NSDictionary *json) {
        self.picnameurl = json[@"ret_data"];
    }];
    
}

@end
