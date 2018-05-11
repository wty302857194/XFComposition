//
//  CompositionCell.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MicPianduanmodel.h"

typedef void(^SelectItemBlock)(BOOL isSelected);

@interface CompositionCell : UITableViewCell

@property (nonatomic, strong) SelectItemBlock selectItemBlock;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *saveLab;
@property (weak, nonatomic) IBOutlet UILabel *submitLab;
@property (nonatomic, strong) MicPianduanmodel *dataModel;

@end
