//
//  LookStandarCell.h
//  XFComposition
//
//  Created by qiannian on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookStandarCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
-(void)reloadData:(FMBean*)bean;
@end
