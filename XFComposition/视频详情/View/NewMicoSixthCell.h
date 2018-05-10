//
//  NewMicoSixthCell.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/9.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewMicoSixthCell : UITableViewCell <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabHeightContraint;

@property (nonatomic, strong) NSMutableArray *datas;

@end


