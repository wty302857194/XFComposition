//
//  WendaCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetActivePageViewModel.h"
@interface WendaCell : UITableViewCell
@property (nonatomic,strong)GetActivePageViewModel *model;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextView *textView;
@end
