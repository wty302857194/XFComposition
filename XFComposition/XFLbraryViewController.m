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
@end

@implementation XFLbraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_collentionView registerNib:[UINib nibWithNibName:@"XFLbraryCell" bundle:nil] forCellWithReuseIdentifier:@"XFLbraryCell"];

    
    [_collentionView reloadData];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return  _dataArray.count;
    
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XFLbraryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XFLbraryCell" forIndexPath:indexPath];
    cell.cellBlock = ^(XFLibrary *library) {
        
       
        [collectionView deleteItemsAtIndexPaths:@[indexPath]];
        
        [_dataArray removeObject:library];
        
        [collectionView reloadData];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
