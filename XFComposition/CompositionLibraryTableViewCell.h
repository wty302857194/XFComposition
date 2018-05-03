//
//  CompositionLibraryTableViewCell.h
//  XFComposition
//
//  Created by wbb on 2018/4/19.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommwritelistModel;
@interface CompositionLibraryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *numPeople;
@property (weak, nonatomic) IBOutlet UILabel *tagLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (nonatomic, strong) CommwritelistModel *listModel;
@end
