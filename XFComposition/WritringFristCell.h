//
//  WritringFristCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommwritelistModel.h"
#import "BookTextView.h"
#import "ParagraphAttributes+Constructor.h"
#import "ExclusionView.h"
@interface WritringFristCell : UITableViewCell
@property (nonatomic,strong)BookTextView *bookView;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)CommwritelistModel *model;
@end
