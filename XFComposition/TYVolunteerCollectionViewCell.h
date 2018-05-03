//
//  TYVolunteerCollectionViewCell.h
//  XFComposition
//
//  Created by wbb on 2018/4/27.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VolunteerFrsitHeadView;
@protocol VolunteerDelegate <NSObject>

-(void)VolunteerSrollView :(UIButton *)btn;

@end

typedef void(^TableSelectBlock)(id model);
typedef void(^MoreMessageBlock)(NSInteger tag);
@interface TYVolunteerCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)id<VolunteerDelegate>delegate;
@property (nonatomic, strong) NSMutableArray    *tabBtnArray;
@property (nonatomic,strong)UIView *sliderV;
@property (nonatomic, strong) NSMutableArray *activeArr;
@property (nonatomic, strong) NSMutableArray *newsArr;
@property (nonatomic, copy) TableSelectBlock tableSelectBlock;
@property (nonatomic, copy) MoreMessageBlock moreMessageBlock;

@end
