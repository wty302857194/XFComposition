//
//  NewMicoSecondCell.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewMicoSecondCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabheightConstraint;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)  NSMutableArray *datas;

@end
