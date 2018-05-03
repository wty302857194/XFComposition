//
//  TopMenuView.h
//  XFComposition
//
//  Created by wbb on 2018/4/25.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectTypeBlock)(NSString *data_name,NSString *data_id,NSString *indexValue,NSInteger index);
@interface TopMenuView : UIView

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (copy, nonatomic) NSArray *dataArr;
@property (copy, nonatomic) NSString *data_index;
@property (copy, nonatomic) SelectTypeBlock selectTypeBlock;
@end
