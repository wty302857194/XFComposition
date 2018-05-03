//
//  AddPhotoViewController.m
//  XFComposition
//
//  Created by wbb on 2018/4/26.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "AddPhotoViewController.h"
#import "BookWritingTableViewController.h"
#import "AddPhotoCollectionViewCell.h"
#import "UploadPicRequst.h"

@interface AddPhotoViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) BookWritingTableViewController *bookWritingTVC;
@end

@implementation AddPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgUrlArr.count+1;//self.dataArr.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return  UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGSize) collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellWidth, cellWidth);
}
//每行cell之间的间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     AddPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddPhotoCell" forIndexPath:indexPath];
    if (indexPath.row == self.imgUrlArr.count) {
        cell.imgView.image = [UIImage imageNamed:@"add_photo_Img"];
    }else {
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTurl,self.imgUrlArr[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"icon_02"]];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.imgUrlArr.count) {
        [self openCamera];
    }
    
}
- (void)openCamera
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.delegate = self;
        pickerImage.allowsEditing = NO;
        
        
        [self presentViewController:pickerImage animated:YES completion:nil];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSData *imageData1 = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 0.2);
    UploadPicRequst *requst = [[UploadPicRequst alloc]init];
    
    XFUserInfo *userInfo = [XFUserInfo getUserInfo];
    
    [requst UploadPicRequstWithfileValue:imageData1 withuserid:userInfo.Loginid withtypeid:@"1" :^(NSDictionary *json) {
        
        NSLog(@"%@",json);
        [self.imgUrlArr addObject:json[@"ret_data"]?:@""];
        _bookWritingTVC.imgUrlArr = [NSMutableArray arrayWithArray:self.imgUrlArr];
        [self.collectionView reloadData];
        [_bookWritingTVC.tableView reloadData];
    }];
    
}
@end
