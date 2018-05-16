//
//  XFLbraryCell.h
//  XFComposition
//
//  Created by qiannian on 2018/5/16.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XFLbraryCellBlock)(XFLibrary *library);

@interface XFLbraryCell : UICollectionViewCell


@property (nonatomic, copy) XFLbraryCellBlock  cellBlock;
@property (strong, nonatomic) IBOutlet UIImageView *imgeView;

@property (nonatomic, strong) XFLibrary * library;

-(void)reloadData:(FMBean*)bean;
@end
