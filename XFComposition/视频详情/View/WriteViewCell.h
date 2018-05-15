//
//  WriteViewCell.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/11.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommwritelistModel.h"

@interface WriteViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@property (nonatomic, strong) CommwritelistModel *dataModel;

@end
