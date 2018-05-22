//
//  BookWritingTableViewController.m
//  XFComposition
//
//  Created by wbb on 2018/4/26.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "BookWritingTableViewController.h"
#import "AddPhotoViewController.h"
#import "ListSelectView.h"
#import "AddBlogwritingRequst.h"
#import "AddBlogPicReuqst.h"

@interface BookWritingTableViewController () {
    NSString *_indexStr;
}
@property (weak, nonatomic) IBOutlet UILabel *teacherGradeLab;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong)AddPhotoViewController *addPhotoVC;

@end

@implementation BookWritingTableViewController
- (IBAction)saveData:(UIButton *)sender {
    [self didSave];
}
- (IBAction)teacherClick:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    ListSelectView *select_view = [[ListSelectView alloc] initWithFrame:CGRectMake(0, kLayoutViewMarginTop, kScreenWidth, kScreenHeight-kLayoutViewMarginTop)];
    select_view.choose_type = MORECHOOSETITLETYPE;
    select_view.isShowCancelBtn = NO;
    select_view.isShowSureBtn = NO;
    select_view.isShowTitle = NO;
    [select_view addTitleArray:@[@"系统分配",@"一星教师",@"二星教师",@"三星教师",@"四星教师",@"五星教师"] andTitleString:@"温馨提示" animated:YES completionHandler:^(NSString * _Nullable string, NSInteger index) {
        _indexStr = [NSString stringWithFormat:@"%ld",(long)index];
        weakSelf.teacherGradeLab.text = string;
    } withSureButtonBlock:^{
        NSLog(@"sure btn");
    }];
    [self.navigationController.view addSubview:select_view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgUrlArr = [NSMutableArray arrayWithObject:self.imgUrlStr];
    _addPhotoVC = (AddPhotoViewController *)self.childViewControllers[0];
    _addPhotoVC.imgUrlArr = self.imgUrlArr;
    _indexStr = @"0";
    
    self.title = @"习作书写";
    GO_BACK;
}
-(void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }else if (indexPath.row == 1) {
        return (ceilf((self.imgUrlArr.count +1)/3.f))*(cellWidth+10)+40;
    }
    return 210;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"f4f5f6"];
    return view;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
//保存
-(void)didSave{
    if (self.textField.text.length == 0) {
        [Global promptMessage:@"标题不能为空" inView:self.navigationController.view];
        return;
    }
    
    XFUserInfo *_xf = [XFUserInfo getUserInfo];
    AddBlogwritingRequst *requst = [[AddBlogwritingRequst alloc]init];
    [requst AddBlogwritingRequstwithNoticeName:self.textField.text withNoticeObject:self.noticeObjectId withNoticeContent:@"" withNoticeID:@"0" withuserid:_xf.Loginid withmodel:self.modelId withposttype:_indexStr withIsApp:@"1" :^(NSDictionary *json) {
        
        if ([json[@"ret_code"] isEqualToString:@"0"]){
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",json[@"ret_msg"]]];
            NSString *writStr = json[@"ret_data"];
            
            for (int i = 0; i<self.imgUrlArr.count; i++) {
                AddBlogPicReuqst *requst2 = [[AddBlogPicReuqst alloc]init];
                [requst2 AddBlogPicReuqstwithblogID:writStr withblogPic:self.imgUrlArr[i] withuserid:_xf.Loginid :^(NSDictionary *json) {
                }];
            }
            if(self.saveSuccessBlock) {
                self.saveSuccessBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",json[@"ret_msg"]]];
        }
    }];
    
    
}
#pragma mark - Embed And Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id destViewController = segue.destinationViewController;
    if (self==sender) {
        [destViewController setValue:sender forKey:@"bookWritingTVC"];
    }
}

@end
