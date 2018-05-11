//
//  NewMicoFourthCell.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/9.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SubmitCommentBlock)(UITextView *textView);

@interface NewMicoFourthCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@property (nonatomic, strong) SubmitCommentBlock submitCommentBlock;

@property (nonatomic, strong) NSMutableArray *datas;
- (void)resetFrame:(int)count;
@end
