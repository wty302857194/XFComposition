//
//  WaterWaveView.h
//  XPFWaterWaveView
//
//  Created by www.xpf.com on 2018/2/24.
//  Copyright © 2018年 www.xpf.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^GoImagePhotoBlock) ();
@interface WaterWaveView : UIView
@property (nonatomic, copy)GoImagePhotoBlock goImagePhotoBlock;
@end
