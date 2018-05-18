//
//  BookWritingTableViewController.h
//  XFComposition
//
//  Created by wbb on 2018/4/26.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookWritingTableViewController : UITableViewController
@property (nonatomic,copy) NSString *imgUrlStr;
@property (nonatomic,strong) NSMutableArray *imgUrlArr;
@property (nonatomic,copy) NSString *noticeObjectId;
@property (nonatomic,copy) NSString *modelId;
@end
