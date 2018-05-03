//
//  VolunterrFristFootView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/19.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VolunterrFristFootView;
@protocol VolunteerFootDelegate <NSObject>

-(void)gotomoreActivity;

@end
@interface VolunterrFristFootView : UICollectionReusableView
@property (nonatomic,strong)UIButton *moreButton;

@property (nonatomic,strong)id<VolunteerFootDelegate>delegate;
@end
