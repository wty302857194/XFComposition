//
//  VolunteerFrsitHeadView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VolunteerFrsitHeadView;
@protocol VolunteerDelegate <NSObject>

-(void)VolunteerSrollView :(UIButton *)btn;

@end
@interface VolunteerFrsitHeadView : UICollectionReusableView
@property (nonatomic,strong)id<VolunteerDelegate>delegate;
@property (nonatomic, strong) NSMutableArray    *tabBtnArray;
@property (nonatomic,strong)UIView *sliderV;
@end
