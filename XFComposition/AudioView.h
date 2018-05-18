//
//  AudioView.h
//  XFComposition
//
//  Created by qiannian on 2018/5/14.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AudioViewTapBlock)(void);

typedef void (^AudioViewPanBlcok)(CGRect frame);

@interface AudioView : UIView

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic, copy) AudioViewTapBlock tapBlock;
@property (nonatomic, copy) AudioViewPanBlcok panBlock;
@end
