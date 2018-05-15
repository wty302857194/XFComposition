//
//  YasicClipPage.h
//  DynamicClipImage
//
//  Created by yasic on 2017/11/29.
//  Copyright © 2017年 yasic. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^YasicClipPageBlock)(NSInteger index ,UIImage*imge);

@interface YasicClipPage : UIViewController
@property (nonatomic , copy) NSString * urlStr;
@property (nonatomic , copy) YasicClipPageBlock  imgeBlock;

@end
