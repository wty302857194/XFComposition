//
//  NewMicoSeventhCell.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/9.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "NewMicoSeventhCell.h"

@implementation NewMicoSeventhCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.courseCollView.delegate = self;
    self.courseCollView.dataSource = self;
    
    
    [self.courseCollView registerNib:[UINib nibWithNibName:@"CourseCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CourseCollectionViewCell"];
    
}

- (void)setDatas:(NSMutableArray *)datas
{
    _datas = datas;
    [self.courseCollView reloadData];
}

#pragma mark --delegate

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CourseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CourseCollectionViewCell" forIndexPath:indexPath];
    cell.dataModel = self.datas[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.showDetailBlock(self.datas[indexPath.row]);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 20, 0, 20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-80)/3.0, 120);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

- (IBAction)showMore:(id)sender {
    self.showMoreBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
