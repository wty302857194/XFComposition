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
#pragma mark --delegate
-(CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath cellContentViewWidth:(CGFloat)width tableView:(UITableView *)tableView
{
    return 130;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CourseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CourseCollectionViewCell" forIndexPath:indexPath];
    cell.courseLab.text = @"jsskks";
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zd", indexPath.row);
}


- (IBAction)showMore:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
