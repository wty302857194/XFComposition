//
//  TYImageEditViewController.h
//  MyPracticeViewController
//
//  Created by wbb on 2018/5/11.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XFCorrectViewController;
@interface TYImageEditViewController : UIViewController
@property (nonatomic, strong) XFCorrectViewController *TYCorrecVC;
@property (nonatomic,strong)NSString *PicUrl;
@property (strong, nonatomic) UIImageView *imgView;
@property (nonatomic, strong) GetWritePicModel* picModel;
@property (nonatomic, strong) NSMutableArray *vedioArr;

@end
