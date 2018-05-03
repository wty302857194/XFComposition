//
//  PostHeadview.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/1.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostHeadview;
@protocol  PostHeadviewDelegate<NSObject>

-(void)click :(UIButton *)bt;
-(void)pingluntiezi;
@end
@interface PostHeadview : UIView
@property (nonatomic,weak)id<PostHeadviewDelegate>delegate;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIImageView *xximgView;
@property (nonatomic,strong)UILabel *txtLabel;
@property (nonatomic,strong)UIButton *bt1;
@property (nonatomic,strong)UIButton *bt2;
@property (nonatomic,strong)UIButton *bt3;

@property (nonatomic,strong)NSMutableArray *btnArray;
@end
