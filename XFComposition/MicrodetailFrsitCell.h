//
//  MicrodetailFrsitCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLAVPlayerView.h"
@class MicrodetailFrsitCell;
@protocol MicrodetailFrsitCellDelegate <NSObject>

-(void)fenxiang:(NSIndexPath *)index;
-(void)shoucang;
@end

@interface MicrodetailFrsitCell : UICollectionViewCell
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *scLabel;
@property (nonatomic,strong)UILabel *llLabel;
@property (nonatomic,strong)UILabel *cyLabel;
@property (nonatomic,strong)UILabel *fxLabel;

@property (nonatomic,strong)UILabel *teacherLabel;
@property (nonatomic,strong)UILabel *mobiaoLabel;
@property (nonatomic,strong)UILabel *duixiangLabel;
@property (nonatomic,strong)UILabel *biaoqianLabel;
@property (nonatomic,strong)UILabel *sjLabel;
@property (nonatomic,strong)UILabel *miaoshuLabel;

@property (nonatomic,strong)UIButton *collectbt;
@property (nonatomic,strong)UIButton *sharebt;

@property (nonatomic,strong)NSString *url;

@property (nonatomic ,strong) NSIndexPath *index;
@property(nonatomic,strong)CLAVPlayerView *playView;
@property(nonatomic,weak)id<MicrodetailFrsitCellDelegate>delegate;
@end
