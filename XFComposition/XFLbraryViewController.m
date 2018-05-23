//
//  XFLbraryViewController.m
//  XFComposition
//
//  Created by qiannian on 2018/5/16.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "XFLbraryViewController.h"
#import "XFLbraryCell.h"
@interface XFLbraryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collentionView;
@property (strong, nonatomic) IBOutlet UIImageView *noneImge;

@end

@implementation XFLbraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_collentionView registerNib:[UINib nibWithNibName:@"XFLbraryCell" bundle:nil] forCellWithReuseIdentifier:@"XFLbraryCell"];
    
    if (_dataArray.count == 0) {
        
        _noneImge.hidden = NO;
        
    }else{
        _noneImge.hidden = YES;
    }

    [_collentionView reloadData];
    GO_BACK;
}
- (void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  _dataArray.count;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XFLbraryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XFLbraryCell" forIndexPath:indexPath];
    
    cell.cellBlock = ^(XFLibrary *library) {
        [SVProgressHUD showWithStatus:@"正在删除"];

       [ [XFRequestManager sharedInstance] XFRequstDeleteCutPic:library.ID :^(NSString *requestName, id responseData, BOOL isSuccess) {
           [SVProgressHUD dismiss];
           
           if (isSuccess) {
               [SVProgressHUD showInfoWithStatus:@"删除成功"];
               [_dataArray removeObject:library];
               if (_dataArray.count == 0) {
                   
                   _noneImge.hidden = NO;
                   
               }else{
                   _noneImge.hidden = YES;
               }
               [collectionView reloadData];
           }else{
               
               
           }
       }];
        
      
    };

    [cell reloadData: _dataArray[indexPath.row]];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(120, 190);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
