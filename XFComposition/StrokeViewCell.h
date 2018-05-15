//
//  StrokeViewCell.h
//  XFComposition
//
//  Created by qiannian on 2018/5/15.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrokeViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imgeView;

-(void)reloadData:(FMBean *)bean;
@end
